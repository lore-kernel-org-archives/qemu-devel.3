Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16FC5CCA462
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHT6Q-00085G-P5; Thu, 15 Oct 2026 17:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT6G-0007un-Bt
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:34:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHT6E-0002ZT-JK
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 17:34:56 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3Vfg406161
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iN/rqKXAe1KcINM61itdxrmlkHhJXTCCmUoAw7wDtSM=; b=XOXG+EhlsC4wh96p
 3iCNDsi+83UirTeQA6ur+HknDu1gV8vbwbfoC+7DjyQepK1D88rvrrCt4aIt0MJa
 sZKAgo+28OgDroRHcoqA2Ja4Jm+sViaS3kwnU0rB4nDbdNNV+hMIvOY5xcDBmQBV
 45AdFFN4q+u8yqfPaxLbHzGxXEZE5rxSz4/s2H3OhXhdZNCnYg2GbF3HwYAsWWOs
 yukuwlGYw7Kqgd6Xuh+Q0QPQsbrdZRGhjsPHIXXeK8Cs5a8usIEvm+QBJsGeYxU+
 xoW+SMchV6PKJOdFs6IH3tEyQqXX0+jS+vvQ3OFkrskzGqI1HAeNU73B6heoit8k
 3Y+4rA==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa0q8r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 21:34:53 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1663fb7e005so7270262c88.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 14:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792100093; x=1792704893; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iN/rqKXAe1KcINM61itdxrmlkHhJXTCCmUoAw7wDtSM=;
 b=bPb9zyIkGlBYDQ8YHO5TCcfNY6RT2/q+vk78AVIgRUexwnOefuakgYBts0gdrADFb0
 tLJhd7JPDekEkcdCRY4dI3ctL7LB5keDlEC20aMelRVVQEhx500xi6XpgYKOUZOKmGmL
 gfxuZLq4E0tW7yJZpG/qjQ0TXo5kQePsLgR/hG7bFtZCNx/ks/tpgV/OnKqjIKJhrTG3
 iBdA13cOanshlCW6LacdRJtAv3NZ5qTM8WeiHjr4hiMSkfOQWKnvpjYr6tbhuPQOKSgz
 ywhVNMsZhqkIXRv582cR06OlBZnPY686CEZAUDOEdhQ4nRdeR2XfdEGc8bOX7BrWz6PO
 VjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792100093; x=1792704893;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iN/rqKXAe1KcINM61itdxrmlkHhJXTCCmUoAw7wDtSM=;
 b=1b3yn/Em/kKVwANna12obk3iIWRFWSzvh4n4ZsI3elOI2Wtyh5FjIt+7QCbAipR2+d
 M0WYwPFerTkh8+0N/SGT5RPNrH0UauWT3/AUbrnioerw/czDGmjbSLc9ALhZo7NKWyea
 fd0CwDNsHRYrCCqUGsMfnw8kmRfGbT9LLl5jCPE4oxtTggicSGVrGzjDTHe/Q3V9AyGo
 41ky9CTeguCAp0NMjCTGWxP6544EYtkP6YqTR5k8jKBJwqADABoaNiWOriiCP3hUpaih
 QpH2IJnxjABfNa5Of7duvfiQsCawy0r+TW6WkoUYCOBgjJYYLPDNmtTGXN9XQNCUH7wG
 p4jw==
X-Gm-Message-State: AFq9FYITEaPVjJ+bVhM8SP+p0YCTRkpynL6cM3803elC9SEws6WNgfED
 XdAFC4SHMltKPKK3OxCvQG0BNaLUgx25hA/bEYXXJeGXe6Em/8DfAFDEvHHJEIjxHP4NHLtydXR
 3mz+Zf3d/ulyWAvHJgqEm5UD1euZ0NhewltzkKafjIhZ+7R4MXaGqw3VkgCr6yqyjaA==
X-Gm-Gg: AYBFou04lId10k0TmHNMR/4lxAQBv39cXkAAKi/WlCEXqVkTUuT9GZR/DbDZxp6slnt
 3O/owg16HpmQOhhC55oqKDQ4wzctiXOBTeUqsSoWyu/Ew4pSLeQCG9GdG0QV59pIlPo3a4hziW4
 Q6GoHU6UqpkZuZ7CRzcfqoRZHeoNYcOFf4JhzqIJ5U+sHgPJelonq24hGXTBiHyzroz0s7oo9dc
 3AjG7yDHF7FKrolPpCABwFtGyy0YaJ7X0Z43Qx+DT+h0uzmdzD+LSGEpF9iB6VXuATtKmPlhmc/
 uEdRdG9jAC30tFqiTb9bHx9eEP2z/jHlPHS1ukLtrHdkKCxyumF1iNQaHlxTCqpSpWWJZ1vvKON
 chOqFMsaxjvrcKzmLljvB5ckU6zRlUuXFwvUEVLHLzDmHcUFP+G2EW0m5XuEoQU+2HtsTKw==
X-Received: by 2002:a05:7022:f90b:b0:14e:d0ba:7569 with SMTP id
 a92af1059eb24-1717e5e9c58mr16037196c88.6.1792100092427; 
 Thu, 15 Oct 2026 14:34:52 -0700 (PDT)
X-Received: by 2002:a05:7022:f90b:b0:14e:d0ba:7569 with SMTP id
 a92af1059eb24-1717e5e9c58mr16037168c88.6.1792100091652; 
 Thu, 15 Oct 2026 14:34:51 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36082784ec8sm648342eec.22.2026.10.15.14.34.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 14:34:50 -0700 (PDT)
Message-ID: <69aa57cb-a666-4fd5-a16c-a8b05050a76e@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 14:34:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/19] multi-target: remove dump functions duplication
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 anjo@rev.ng
References: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261015213236.157767-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4NiBTYWx0ZWRfXzueUYMkFaAUg
 Zfh4vvLEx3bdK8RLPClaX7yQb8udrRuOuukxTfwkXmYkmls3sUnQDoPqhQuhu7/RBCuCljBPZIh
 kbDntpmA2UdZYDI1UJXsPp6dYsPweQ4=
X-Proofpoint-ORIG-GUID: Qy8rX82hC-Ylyh_u9GZMu90ZouSR9YCZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4NiBTYWx0ZWRfX1AaGfRRCi9Wu
 YjyJcWw8COHtlrxayjVYcTgp2gvv90KegVDd9UdFlzQPwHUAX4ttjTB14J2y9TFSbWlN31ikWTi
 dQiG60oh6TidiCpQ+H3LnznrT7ui7nC1QsdC2za+R07nTNxg/BEq5gyfV9FxwznXp07UCJvH2KE
 nMyqHB9Tj9+OLMzPN1sAyMZUdQ2p4eE3JWDtEFcqskvJ1dK1ACcbzki2cukW72hhuCOug8804UX
 kRTPcFwXgKUHSlpYmeb3NwRdMuDpoQOsisGr4Z25s+DdW7Ly9cWSiLxsUdIGgsjLx4ihasHmwWS
 4+pGRgYL9Sh73jsmzy3e71kScDPWvx/BtLJG+rNuAYj0I/xRmts8phAkLuVgQDW2P/I328blKdt
 HcEJ4NWLbhOxm0Lgm6kqhsgss7pDKJFCX4IrSu99N1x58pSfLlrLIg8C8qzyVP4NRi9C4asXpdm
 rPjdxR5gE+9rBCgPz2w==
X-Proofpoint-GUID: Qy8rX82hC-Ylyh_u9GZMu90ZouSR9YCZ
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad146fd cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ImvGMAJ0nd_Ly3Dt7pIA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150086
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/15/2026 2:32 PM, Pierrick Bouvier wrote:
> This series removes duplication of cpu_get_note_size and cpu_get_dump_info per
> target. For this, we define a new set of Dump operations for a given cpu, and
> implement it per target.
> 
> Existing implementations were using first_cpu, which is what we continue to do.
> When we'll work on heterogeneous later, we can revisit this to either forbid a
> dump, or perform a dump for each target active.
> 
> Based-on: 20261014210526.104215-1-pierrick.bouvier@oss.qualcomm.com
> "[PATCH v3 00/12] multi-target: add hexagon"
> This base is only needed due to conflicts with current wip, it's not important
> for this series implementation.
>

I forgot to include v2 description:

v2
--

- Add new ops to existing SysEmuOps instead of a new DumpOps.

Regards,
Pierrick

