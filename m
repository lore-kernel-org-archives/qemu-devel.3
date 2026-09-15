Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2729EC88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 00:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6HPT-00017g-0U; Mon, 14 Sep 2026 20:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6HPI-00017A-U6
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:52:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x6HPF-0004hy-U6
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 20:52:19 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EN0Bjr1813489
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +DWnlopHtqo5+55UH0P85CaKO1UOsyASFf3UcOxLUQE=; b=CkuDdcCNcvqMa8dy
 gHcFQhHSwT6vWfJd0DNFqRZjDItrm3EH/gyEmdBTper6nYAQtr/k4svi/8wBMQ1V
 +CsdIhA6Su9IP8YBLaV8dJT7OwXcE2XMOUh4otlY1SyTqB0+LhVeVufpc/U87gNB
 60bqYbcatLYAljkqOhv1T68qJOPj9dBamlC0dF4r78AZrQyDdQJ+FT3xt2BjHvlf
 dHEe5J/+ktGLyb1aYbYbTWJuNR9TW+gZD8/t54aDM9BNos3MT4QmQ32bavcOiRzY
 Zcy/kky9LNVqs4bixBMYQPv0h98wx/MvHnJ+mh3XUGyGLiZFbMoaTY8rDX+Qaz6p
 eELUKA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpgvtjrs1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 00:52:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52fc16ac179so8062391cf.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 17:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789433536; x=1790038336; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=+DWnlopHtqo5+55UH0P85CaKO1UOsyASFf3UcOxLUQE=;
 b=PRD2lapbYxw6QW5WNcn8ueyMP4jdfzY3fG45Qk19DHIB/2Du8HASqa7daCXebDkBu/
 kodJV9LjjNOfLf5Ajq6yvbFIarg6bZCrGQCm3yX6udPgt41VYW/gXTp6Rnb3coAMHoUx
 4FJpZ5jXnMZsN/daWhMcO1+i4B3PlIjeGOEvogKhgSPMwnDN43IsCt0I6I+9WGsoDK8b
 KngNYEt3TzM2kPcGLK37PM4/jtvwHt+UcByGY2+TeSq5qKxMBzo8pL9FUMci+P4UY/h7
 z0kkvpBSbCK3d1hIC+crG46gXqvvLBDVLvKgXV1+TmFpXJvB3Tl9f42dz60tix0inWeP
 DcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789433536; x=1790038336;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+DWnlopHtqo5+55UH0P85CaKO1UOsyASFf3UcOxLUQE=;
 b=NUOmjQ7pBwkZ4uWNUVFmw2Li9ksc/7HsQ62GpjTk3au9zuyetFdY8VJ4t9H04owDNm
 B6APsYhtX04oQHIjfNyVOOiZb4WsJNsZZ55AZd7xCv1fCu94XHDj3+sWo2PtzQrCFQPd
 SZx46fwki9GHRzSpwGN0iI59/YbSgM4ohURYZ9pL8NVSShUGU9T4PWWQxddTDqskstjl
 ytbxy63v62SkeLXYxCycHbDm0MRLliL4DFaxd0XZqRSOmuFs6P9YCFmPEOz/kzOYP/tX
 hJ6+rfHuWtoknNOwbx0hcsPhtHr6BvhU6LPKdVSLd/Ay8VNM4TXiihSHopAbdvXX704y
 LJVg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx+pBB5UiB53O4mrpQ2drjW1DLVrwSu1HWyFrKwB8Dvze9V+wAcctKs4O6niOJ+eFljxsZ+npDH4fpq@nongnu.org
X-Gm-Message-State: AFuF++lJSBSD2lJ6Z1viB7wWnnCfDChszPbg3sMyUjsEFBU3bZFgLk3I
 vXwaQpjUAAsudtSNgPn1A2pesbYOZTFJIE2sObYBWyTH/KrXkH9mgapbvdA0Cwi3NOKGK61Mmcq
 +S+kMPhSgIWW+vM3XNigcU0uYvJtiv1M4ewUowgS9Km1KbKouOQHjsVLe0Q==
X-Gm-Gg: AYBFou2y3wKyJ+TONpBedDaHJueUqdGgiKP9Bx6XeX0TXrwVQCmihV5sqpb5T4YyENd
 x/t2FpH9F/tyPU3mVqzeTfY1cN+aw27zEqSJxMJyzP+M+ab1rN5+8UDLxi9erumQUZeS2MI4ARW
 /yX64g03PcQkhdacELJMNe46TdoJ1fpbpD0dCeWQL28dOaxP+6rj1eHHOyh/VXSkOgZKeCkF1d5
 Gllc+GjFV/IY826uJZ740x0BLz130rucFw2z6sckbx543rJSvM7wYWCGH6sC9RlgSgrG3/C0P5e
 maOS9vhN0XbvjVVIebYhntqOHtFtZp76I54pX8piLStB8jH/vq6UAA+VLjI5UFJcbjNChnLUZqD
 fMpFnoJx6yPi6+rwPdZPl7BA/Ui2W2sSiujjBuo1XrONul5Kt4qp2L9rEZu7D
X-Received: by 2002:ac8:5e47:0:b0:531:608:1010 with SMTP id
 d75a77b69052e-53119e9b56cmr23419141cf.26.1789433535930; 
 Mon, 14 Sep 2026 17:52:15 -0700 (PDT)
X-Received: by 2002:ac8:5e47:0:b0:531:608:1010 with SMTP id
 d75a77b69052e-53119e9b56cmr23418801cf.26.1789433535479; 
 Mon, 14 Sep 2026 17:52:15 -0700 (PDT)
Received: from [10.248.104.162] (16.sub-174-226-168.myvzw.com.
 [174.226.168.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530d5e946a0sm102616331cf.25.2026.09.14.17.52.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 17:52:14 -0700 (PDT)
Message-ID: <c761985f-b0c5-44f8-a76e-24226369f7c5@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 19:52:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] Hexagon (tests/tcg/hexagon) Add tests for qreg
 multiple writes
To: Taylor Simpson <ltaylorsimpson@gmail.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, sid.manning@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@oss.qualcomm.com, ale@rev.ng, anjo@rev.ng
References: <20260914215037.157879-1-ltaylorsimpson@gmail.com>
 <20260914215037.157879-8-ltaylorsimpson@gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260914215037.157879-8-ltaylorsimpson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=c/0+0h9l c=1 sm=1 tr=0 ts=6aa896c0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=HnZmebILR7CVcA10YZfY7g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=WdpXueYeivpW6bUSVfgA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDAwOCBTYWx0ZWRfX+PBJHohMjR+2
 xzqe4F6q3wuy1vw5ZGvTaqWx6opr4DtI3LAoL3kvGnnErHNNT+Ifeu31/qyD6DOfnH+TBah4Gno
 DpDOgTlXw4ZiYpBKvqA4kFdtPwQR2gMN++z4qLlmxcNvIyUO3dLie7vFQAYAP/NhSOe0rRIHbB8
 5cLGFlYi1LvZCnDM9/3Fq+//KPDlIiousuWmkFrLN18GOjUxCq0A4gn6ROIpR9O1Ud5Yb9MmIZU
 TFsWcUcozoUuQWJA9iYgtdHR1hF6OTEZXVESzIABo+PnLIgKXxK20q7kM8XYaURD1jbheaXS9PX
 Z2rNkeoLPZ+bAoFGDv7EXIRui+C1Wy9HablCU2o9xzJ7XwWzAkC3uS32ah0KHO2D0gcCgW6Zjk0
 zhptbQOzUN1I/2OHxgGCJZPoOeM3MNh5GD4LVMKXAOjbZsge6lSaGKnxVI3A97icqTtWoSTS3ea
 qa+UITTHSrtdTYMhWIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDAwOCBTYWx0ZWRfX9FywBLANrsqm
 CLYPZ8JRgriyprQSOgNPcxzfgPfVqnk/QhYV5WoZXTZXXqx21KYJbjaqrBVmimFHYUxBhZkTlJz
 iR+KDuiqXUOPSkiYq76whzuS475FSd0=
X-Proofpoint-ORIG-GUID: -gnrUUhhUunRcdIbwTZru2E1Ty4xb9xo
X-Proofpoint-GUID: -gnrUUhhUunRcdIbwTZru2E1Ty4xb9xo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_05,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150008
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 9/14/2026 4:50 PM, Taylor Simpson wrote:
> Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>   tests/tcg/hexagon/multiple-writes.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/tests/tcg/hexagon/multiple-writes.c b/tests/tcg/hexagon/multiple-writes.c
> index 62e5828a0a..bd2b1384dd 100644
> --- a/tests/tcg/hexagon/multiple-writes.c
> +++ b/tests/tcg/hexagon/multiple-writes.c
> @@ -261,6 +261,27 @@ static int test_vreg_illegal_uncond(void)
>       return sig;
>   }
>   
> +static int test_qreg_illegal(void)
> +{
> +    int sig;
> +
> +    asm volatile(
> +        "r0 = #0\n"
> +        "r1 = ##1f\n"
> +        "memw(%1) = r1\n"
> +        "{\n"
> +        ".word 0x19a14048    /* { q0 = vand(v0, r1) */\n"
> +        ".word 0x19a0c044    /*   q0 = vsetq(r0) } */\n"
> +        "}\n"
> +        "1:\n"
> +        "%0 = r0\n"
> +        : "=r"(sig)
> +        : "r"(&resume_pc)
> +        : "r0", "r1", "memory");
> +
> +    return sig;
> +}
> +
>   int main()
>   {
>       struct sigaction act;
> @@ -290,6 +311,8 @@ int main()
>       assert(test_vreg_illegal_mixed() == SIGILL);
>       assert(test_vreg_illegal_uncond() == SIGILL);
>   
> +    assert(test_qreg_illegal() == SIGILL);
> +
>       puts("PASS");
>       return EXIT_SUCCESS;
>   }

