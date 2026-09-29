Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A2CCCA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWuN-0006Wo-Pw; Tue, 29 Sep 2026 08:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWuL-0006V6-0Z
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:26:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWuI-0004Bj-B7
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:26:04 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCElN34066617
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bvayp27AenJtn/jzWJtZmCPamXWuYGdKPUOK9U5A64I=; b=PlYzZ6dyTuYPD6B9
 ns2FGtkiaN5vlrIWzFhMVmQgDvuX/9u+LpZRCNEC+9dtRNEUhWDv5s7VghcD/hSt
 Qw+AGrP32DJVDsSgdtCvTQPJ3IdT3/SxgnjQsHBf+Lpllr6ESP+rN5kv6yMcX+zJ
 vIUy5tvX2H8uQKkw/S5Gkd2Uzt9B3oNZstUmrufEbLS6tMm/QQ3QUPEXXUaBFNFx
 8vOaP4bKwo9j57qktMl0NnjTuN2pY7/HqmIwsJ2wXyDCyzR+Hsa3NNG4jd1F9x9z
 uF8p2hpMVEKrCehJ7k0q3QLIqz6twryX4e9iMDFTvI1O6kSZiAoyDl2qj2BshqQh
 r9UzTg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyvwnbym5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:26:00 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93ae8e7e546so834425785a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790684760; x=1791289560; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bvayp27AenJtn/jzWJtZmCPamXWuYGdKPUOK9U5A64I=;
 b=AlGqh2xzsnIevahh5M+3Jk7d0zTKnTZX8NRPpUiFiTh7GI9WxtpyOFpNDgZh8dLgas
 wgZb1dQ8K9kKpnv7f5lI5xUpMV5kIXg0zfVNuKE8/3dBBWXRBMxZ9RvDP1Ozhx5g0E0d
 vwjvIRt4HT9c6/YRKAQMQYPOUfpk7Fx9h2q1Q4j+7WFRdNb9qn1pax0bFKIYw3Ir7n7A
 PT9QFfm+xbGzUf1yhukVfxTppkkgopVdZhpEZd34ZvtSKQ2nsnGyUFiNzmhL2M+Fcmsl
 Iz9K+GibrtSqrA3qKUxgVXgDirLkF+TgIfj36qXpS2VBkk5VobuZewFV+V339IDDP9ND
 XV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790684760; x=1791289560;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bvayp27AenJtn/jzWJtZmCPamXWuYGdKPUOK9U5A64I=;
 b=s0hbd3Z5l0aHm9wOCFZOHSZJCH1jVJ5O/FNFkslyBo7IjoXmoRhpsWMrKN8Jr5gWhu
 tETQqmwMOZAO9Z0L1VkTAnZ+463vj8rpreSaiZQjWqV/itZCmS7Vz/oI03PNWT0DpfaC
 BHqd6XbsHdbb7f/su/yhgWugOCO0p28SO27yTocSIpRvRn8Dcpj24MbynQuB86wUnpqp
 z6Ep/uvv/NjwFq2VPk3wH1X0w0ma2ONIcDPiXG74SiD4AYQN3f9+rT/idFe/0yoVQe8q
 VCzJZsWOFFD5hVkzgc2hOrdOz7N3V91LVxqtU3u4qyPzNxN7VicK05mlGpyw2PLVCgeM
 V53Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByDgPImGk2VqNVZuyFhBmp95LQSZ4qgh+Euh7zk57QEfgSu4cZCWIsmV82cCnPjbvQQIFXK4Hneg6IK@nongnu.org
X-Gm-Message-State: AFuF++mQP7BLjfKW315hU4WBKcmGE+vX2hfdakm9DC/idKXdoPUjLZjV
 SFpDtkof4ovUT43KWfU3nvPRz9prdw74gHp10Ok8KRs2/tPusL5vAYtN2J2EMj5RhuxTXXWLxhz
 oGZn4tLK2/VI+jb2vFxNni7luK9/iQyj2SWvtHzunIbAosZJ2WnSO2pxXGw==
X-Gm-Gg: AYBFou1v7y53FYW/wevUSFUOqU3+Pdpi5FLzowPLZED8HIZ0tHXi+q12t7R2HG+s5VD
 vkpxYOsuqfyoeBICEiujIFJaRQ38rXxnk5bLBZCqwYaY23LTAo0Iu/geJgwM/CBxYOnP7BdDHDp
 Ut6ohFmFKkdzmUiM/V8L8cB37Xt14h1F0M2Fl/p9AyedoOiqcJ+KxS7DIhfm0IW4vSY41vgjju9
 1yfZ3kwdGi+gjzNNR8piJLrZS6LFINntKDTen/0Ig7868pCfBUKFtdFii7/rlTidS9OAG1fWczS
 ahhMq44CpY+mgwMiliGfdqZBkTvJpMshiaLru++0WJnabhb6wDdDeZUC57+d/LHRG0kpTHbBm2N
 bjkh8ui878UU02/Uh0Dy82BAKBESGkMvTlg==
X-Received: by 2002:a05:620a:470b:b0:93b:f402:a204 with SMTP id
 af79cd13be357-93c43cfca2emr2774302085a.51.1790684759619; 
 Tue, 29 Sep 2026 05:25:59 -0700 (PDT)
X-Received: by 2002:a05:620a:470b:b0:93b:f402:a204 with SMTP id
 af79cd13be357-93c43cfca2emr2774297385a.51.1790684759107; 
 Tue, 29 Sep 2026 05:25:59 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af50a3c49sm3747284f8f.34.2026.09.29.05.25.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:25:58 -0700 (PDT)
Message-ID: <22a3e1af-b862-4f70-bb1f-9ff96f0bb0f1@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:25:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/42] hw/misc/imx6_src: Avoid casting from void *
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-36-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921214710.29422-36-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9XzzDhrZLfdTY5X0odVPokyMFedui_7-
X-Authority-Analysis: v=2.4 cv=W42txhWk c=1 sm=1 tr=0 ts=6abbae58 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iphPbDPzkScA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX3XhJUciDpMS9
 PQX8LLwlIcxQ7qzOTi6uKl8llk4judVLecq9BnqG6WPP0oXNtfHTpNEMPYqDgxfoCMsxKiM7oXx
 y9Fy1qSDKl2Wf0whWjCTCAQ5dIhqqngESgLzZ9QsQnBzLBnN455O+FHQrcCbehShtmL6Xogxl/g
 cpQvQRs3MmekoKJdDQD+uZN+FH4zbCnIMGqoJbJFYM3qoPX2O7OiYmhJgE6N1zgYTjLiq/1QHkY
 MqEQqMiwDLowZ7yV9fgLes5+uSXL4XdxFM3Xd9VJjTBLUOSbYhvibSfvsxVv/ie7F/1Bzft+R1v
 YYOTAmv8a3BiTwGI00UCElywryHllzmrvxoGRz2igcG19k8/dkOyO5kID6eySZ1Dd21fq9pg4Uy
 gwLBPD8iQ8gTMbQAEjBty7s4gv2TKCRgg6AkW3n4rBz8W5h00gOoNkN6edJmm4jaaKvyqvwCNC+
 FecmTwsVyNn7UYtTQKA==
X-Proofpoint-GUID: 9XzzDhrZLfdTY5X0odVPokyMFedui_7-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX4VHKZ0CirnvO
 vWQx0DaCYlGcLL+pAjhd2QE8JQJtx1AhJWWWDt+JBVziRKBReBqEPDR7g/26fkpGpJM5x9XJDj2
 OJJKSj2yyMiYqSq59J2Bbp9W2E2Xpig=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290049
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21/9/26 23:47, Bernhard Beschow wrote:
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/misc/imx6_src.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

