Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C786FCA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCP0k-00033g-JJ; Thu, 01 Oct 2026 18:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP0i-0002zl-6z
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:12:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP0g-0003DR-L9
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:12:15 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsVJ42475306
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 22:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KN9lz7E2kBIk7ZyJ9xfIZhdwpERHlQUThvA56rClxxg=; b=e+uBKCJ2yFY66kkK
 WzsSsvd0ZIIgbssEonIOqa0OrUJN3kY+C1AiaG2ft/M83IVXB2EKRpxBhyIQcnP6
 gf8j6vkY5VH3CwVpW2RTJOpTknvrPwZBDItwE0VawP5XPwgb+GgHjz6t6Wye0wwC
 0NLtlFfYV9IIgNR1G0Z0rYQTTar9L8Mt/gGbXoNayxqSi7xK6pa8+Anqct46Tapc
 CvWG5kKyTpE7/a00j9lgAIXwUBTYFoThWIzjeVc9COsC9q/p25UqxYeHi9S8PEZv
 cBSgh9ibIayxsbKjn5nbyBZGLZHWxfITjnUU5pxOUYfj5hIpsBjC5dSj2KV0lfj3
 EBnJMA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1tbg9jh3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:12:13 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c0d568830so13612165eec.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 15:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790892733; x=1791497533; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KN9lz7E2kBIk7ZyJ9xfIZhdwpERHlQUThvA56rClxxg=;
 b=KZovaO0KTo5daM9e7oLJ/McQm1muAxdNWxNEcJzQ+2dSwUn9gUbOd10u4Y+7UlRdsj
 TpkjUkRwe7t8lcattEhyxdGUWSqphdzmK+eeEYb1kv8AcTPDmvjug2WvWYImflZH5LVR
 I/8ppJ5ncb6Qj0P518bjngq4hdmtjaGITiZ0tT+6i7Jc9aCRVbM8YsWmFzrGgaOrN3Zg
 0M7HTA+yuCAwjj498NnrPA2Ij144fqmpaB2aq8iT3KJeCrDd+pqf2TiX/WJa6tEj8K0W
 Y6M7hPUhr9Mqp+2NsjZP1YucSxhm47A8uDJ9aAYtXo7rZOo05xxtoYNGOWdjrIZOW6rV
 QLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892733; x=1791497533;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KN9lz7E2kBIk7ZyJ9xfIZhdwpERHlQUThvA56rClxxg=;
 b=CJpoKf5wi7yMchZV9UfNpwX8d2c4OV+prn7nctSxS0S/6JxtKesH8TWCsMa89FSbSA
 4Q0QR2oUkM71TNmDP0Lhv/IeGdXzvUfLIn4hzTNdAAeU2gnsGlf8MJuFYArWNRQHpcU9
 d0R8HIVC4h6LxSYcAiftXrmKDDolCVjqWHhX8lxka58N5uIMPTQIPC0EWELTxQdWYad6
 w792pyZiYwnbnA/IFkuQzKrz30/CpP47RztUIgynWYUWs8QQa6C5zzPdb0+zVq6lb/yA
 //0IMgrhYR9z/tCXsq/WOY3oD2TQV/R/J5Y1styPA//heayHFKd2p7ZUoJHlBRF8exD7
 5Frg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwmQf1ueMeRogm0Z9PyKIIRmvg7keEu88lPNa+h7sgqM2j3xPRlPSGehAJ/SXR9wmqlqdBQKzOiPEym@nongnu.org
X-Gm-Message-State: AFuF++mCP2a2kq8t5TFbAKfWZerGGbdiKvbMVnCwsb1aU6I1++AKPy8S
 jLXLIQz/I5OBAweOBvrSQsGtSXlzNNPs2eZC62BCSPlAbx6Z2y9yJ1hRPgd21BX+iEKFRMlyh+F
 dYSZOBNXI2mPb6NokIpz54cj8jUff8Nwt5M5lw/1L7whuiAEQEgBdaiRt9A==
X-Gm-Gg: AYBFou0kuo/s1e1Xkru2o/TlLf/JAt9i8sMQwFFJnk+ZwFqfBOZdRX6winv30a7lmOq
 H37FZF7OVBuf7jIJOtYf9jZIu+73N2DZmzRMFuzVuvd70HWQVNz5BHZS/+U79aWTQvVtydXSNZr
 qpHSy1F8BOKvDvMD5tU+tL03f/sHBtOqScHP764/OFsXtn5BFHQkDkYwJZX1FKEmOj5g0XUcUrd
 s5QytQRu7VdBDG5ekBKT5bevbpL5YcsM0C2pO4Rm/wtcNoNFyI5fWVSMywIEfv8GapMpDUHfs9H
 MLe/uhgcnYtJhQGBOvS6azy3X6IuQgHp6zTYnxTzy+tz/L4T4LbR9YH8xCtsvt5k/76uFZ0gp99
 mruQs0EeP5TBNQMPThe5K6ih/aEnIQwqTsjSq4MNySc3v6xUI3MBzyvaBqA0yVNyHQ713uA==
X-Received: by 2002:a05:7300:10c:b0:34c:df85:8e3e with SMTP id
 5a478bee46e88-34f14f2bbbcmr575782eec.4.1790892732562; 
 Thu, 01 Oct 2026 15:12:12 -0700 (PDT)
X-Received: by 2002:a05:7300:10c:b0:34c:df85:8e3e with SMTP id
 5a478bee46e88-34f14f2bbbcmr575753eec.4.1790892731970; 
 Thu, 01 Oct 2026 15:12:11 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14fd4dd2sm1195237eec.20.2026.10.01.15.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 15:12:11 -0700 (PDT)
Message-ID: <9c1f66d1-faa8-4be8-b1fa-9ed4f039f052@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 15:12:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/18] target/riscv: Compile riscv-qmp-cmds.c once
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-13-ea69b07afd31@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001-rv-dedup-v1-13-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfXwau/rgIKPAf8
 39aPyWigq07+Sw/MUIGV9+NcgR1wIa4U9d6Bf6ThyjqjIDA9oPJrejZcFnofMlLSDWAEqa0SPc8
 Na36bqwNijJuod3eOv90TCxYG38gLwI=
X-Authority-Analysis: v=2.4 cv=QY7zLcbv c=1 sm=1 tr=0 ts=6abedabd cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=dREDruNvXLWMvVqCjPUA:9 a=QEXdDO2ut3YA:10 a=VxAk22fqlfwA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX0mwQsh/vkkvZ
 eKaJgLXIKcgLMvkgO08ttJOiob9TsJsJoeHTIo4yAs6mhzqfnpicpdGR+sSWOeFbvJySS0/FcNZ
 j42VJk3w0PRcDljFA4y4BoQyHbpw0ED3k/VdPJ7OESfHFbG7Sfs6iVSU/d5o+LV2rfdNc3Q6lNo
 SlmDoPD9FiDDtxhC0/ntQZuu8G+G6PgCvR2cZ/DAqkCSiP/53Rduk8THtbcJY3T2byO4KmuxMbK
 mZhltTChkF/oyfQp8eyGx6LnfTwGxiwH4mc4EB9YCKe4ZCQpkV9993ktF84XBnoRupwzX36vPuM
 kVvuBLMihvtlspM3dhOXwFGJ230D9YJ5xZi14atzL4Hc/U6d0Na1KzF0FlFGNAr15RdOcUuCRhN
 5X/eul4SEjkTI/zydYz3KO+dUpJ9vTIu88Jv0e7XqNvLHVWjOe6+aVxpIG8tUP2ugjohjd6GuPh
 LUgAKqSbUfq/3nR+vxg==
X-Proofpoint-ORIG-GUID: ZUCjxnbsxsiG53lXLfZdLEmibzqG2Hjn
X-Proofpoint-GUID: ZUCjxnbsxsiG53lXLfZdLEmibzqG2Hjn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/1/2026 8:59 AM, Anton Johansson wrote:
> File is already agnostic to target specifics at this point.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

