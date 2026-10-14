Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02ECCCC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4pD-0005M9-9x; Wed, 14 Oct 2026 15:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4p8-0005LM-TJ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:39:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4p6-0001Ck-HU
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:39:37 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbNr2152725
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zwsVZnUAk3e4GWTzWhwNaBF2EV5NQDRbsuvLA9J23ak=; b=bw/T5T6w1v6xKjl0
 EJdOdi63hE8OhVOvlt3UVDcTY4DgTS1jEG+z++0DzEFa6DK09FCxrE3JeyDcM9pf
 /sIYxrUVlOZI4Shln5nPJ9m2MVc/0Ly93MC5xHGSrFTkZ9q5+LrqXZSQoih+BBvT
 mitj2+1xXQ5Ou5ePlihROotqcJ677G/Ml+8EW2mF4+I/lGBeh9hIxZCtoebznzEA
 CA42BxXj/m5rMveswWlbuuF95WkluiOsBhDkoyWA56IF0kAR2NnGsuq6g9CTkncL
 dKLz9eBGTCV9n/CA5FXkq4EjZEZFirMhnepF30MtikBVdgAMt1KYlyRoyduj/84o
 crMXXA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aejbyv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:39:35 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93c5ab5c136so781499385a.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792006775; x=1792611575; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zwsVZnUAk3e4GWTzWhwNaBF2EV5NQDRbsuvLA9J23ak=;
 b=fUkZDLATtVfvSxirUal5reaE8axuggJE4C7wkLSshD5Wd9ofv3bIb4RfDyDa0NrEfc
 ut+35s9AcoH5CaYf1e29GzjWg9bVBycFs5kGolde0a/Zea+3LRxetlVEUtl920pCSbSV
 tSOFsAjzHwSu+xtm+7E8tpZ9V3t4FoXAnRsNS6RWNt0fHPZlOSeNqncu4KeDTXbHNHAB
 rUGzNX+WQCytNyoq2t3myd5U2n2jIRzIFdPBnhxMYdRdoB2SL5ysggJ6ilFSdX5ia6lo
 4aZMiERMUNVtn5/51v/f9VuxoXge96OTZHKGX6/JfsPXa+Xp6fVpAzUF9T3yIMoi5xMZ
 M1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792006775; x=1792611575;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zwsVZnUAk3e4GWTzWhwNaBF2EV5NQDRbsuvLA9J23ak=;
 b=qrZE33I0bTp+ibNMZZHd07J+kWixvo7oyeX/wgkSbUYXeI0HU/hp95mJ/KyfzBOmum
 DPMdlMo9iSj8o89AOIpoSEThtmirleVtWDJPa/03hoOgzjPnFdYMkhdWqmMq7qkcX3to
 fAolEbo7Qrvwby3Wa51RDXlmj1EYJ+cqNFpbgNvHym47Mh/QTwr998kUD+NOPXHHr2W/
 noRCal3yjXPpMbzBjUuh5aRTiX6Sox1CDkAC6OPwVVriNCJEDA69/aJQ/tyTv7hWSZfp
 r3T04cZvy1V/c9rXjOEjczPRHFcdVUl6P1xjnQBWkBEK6PTlLUgoy5wEtUOL/cTrogyd
 n8oA==
X-Forwarded-Encrypted: i=1;
 AKwUvByGCTMmvU10twVQf7gWJDeU95vf4N3iTuyDTfImZ6vuTQa2LNvho2TgnMW0htwDTOqIL0L56YmkYc35@nongnu.org
X-Gm-Message-State: AFq9FYL7mxEx/+7IQaRjfkXKCq/ONA3ZrH0IrQRjM9VQFY8gVl8oH1mO
 1V4g4wa0YAe41fxrC9erlZaLJG0VfNbBiUpg+xPc6YXo0JPFRBgvQl2JTDEcn1WV9FuT5xMwhNR
 BEYehOozGzvau/V2B4CNMtkyDGRxpGX2pJIH6hN7I0iKewjKF6bSqeMprEw==
X-Gm-Gg: AYBFou0NstCFf5rkRUbvtmH4MHK4fiL9iPP8mXGcPnZelm++rOmrf1oqo/8aAOCUbgZ
 nFLeptSw3C37aMNr8cCvUFB8NjoabK1q0QtywM0AxZEwsK8D7meRryuuK5j0RLIJ/bGcHKfWsfT
 +jFjPxfFCJswRNP6/2owL/j6FdLSJpVhOsldI5x5A8uFAb4VA2/auE13bdiNQPFbSLBya4w2/Zp
 abCL6a1U89x4X9vKLjxRKQfnmERYFXat2jyLEGkX5FI1AiZ2khAZfpMS66+//A3cjp5XBueDWp3
 Fsg2shGkl+7BI8f82FWqTVc1OplutYhJZJfhrRMnEla8p56bVzWSiSr8D7HK9ytwVehlu/5XXTZ
 clVBDRTQ0CHgFKH4wNMRGpR73npMHAsmkpA==
X-Received: by 2002:a05:620a:7310:10b0:93e:e425:229f with SMTP id
 af79cd13be357-93ee42528d4mr1167537185a.77.1792006774723; 
 Wed, 14 Oct 2026 12:39:34 -0700 (PDT)
X-Received: by 2002:a05:620a:7310:10b0:93e:e425:229f with SMTP id
 af79cd13be357-93ee42528d4mr1167532585a.77.1792006773894; 
 Wed, 14 Oct 2026 12:39:33 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ac52d3sm13684686f8f.43.2026.10.14.12.39.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 12:39:32 -0700 (PDT)
Message-ID: <defca359-9a30-4308-9c2e-20054a0258ed@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 21:39:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/11] meson.build: add hexagon-softmmu to multi-target
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014182543.135965-12-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261014182543.135965-12-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4bUUSqn_3Elz6ijZRdRhBkI3_aNDqYdc
X-Proofpoint-GUID: 4bUUSqn_3Elz6ijZRdRhBkI3_aNDqYdc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX68Becr/S9vW1
 Kae5EPG2mc8ffnRHixrm8uc/uNxqwv94lrpwvSwMXxGBFHQUjfPM+K2HI6d1HMr6V6t4KXGZf06
 QHO+jBJrLp5bkP8kwk3fkYaugI0V9Lg=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6acfda77 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX6gF085Q6zRBo
 xN8kYMWlibFf1v9hYJL0vxYV/XfcXzN8gY98siWVcECdCNkiLUak9OFhr8Ar2R6HDFUICG4HtlQ
 7qd+0aU4oeQ4bdcxcakqkZqdepy3HXGiNQOvb9gWu6f8lhj0fqgyUCPlkmMty75NW0c9YbHUZ4t
 LaPI2SENbJB9yXAwGWATbwgPA//QJFT3Y7Xh1mnnlAbUKPHvYmz692O3uCqzjDW3aujyZ1jCHGV
 55Bf21pP9Lw3SZfyLxhSIqiW9JR8n/4x7ZglT3Cy7Z+WA+M2dFG3FD1n7TBwwAfttOCG1yxTu+a
 j/bdf6K873V/cHSIs43kiOsFRazMS/0fqU2evTGCgk8fsADmHgA4rUra6qlCL2lpFADagpLUm7g
 zSkemUvT9SCF18hR/0zfxD280VXUMWO2y8Sh2jjqhi/0NV1DWbOTkGHkMqnL3BlZ06XWpSUApCM
 bOw/qHsrO1kfxadQSdA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 14/10/26 20:25, Pierrick Bouvier wrote:
> Now that semihosting is solved, hexagon can join the list of target
> compatible with others.
> 
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   meson.build | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

