Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D70CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 22:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQYXJ-0002Hl-SE; Fri, 22 May 2026 18:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQYXG-0002C4-CM
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:40:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQYXD-0003Ff-Fq
 for qemu-devel@nongnu.org; Fri, 22 May 2026 18:40:05 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MGapxY1733113
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 22:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bpg/MoP4gnTWpwVj56a6cJRGbDZixhfx1+1Z8YVR5Xw=; b=ISwOxwskuK5UTx4l
 LyIpyuqfh6jk3fv9F+Fmn2NLDCeqqNNsH3oh1/42mNDG7Sn1JlLklSZLSpmWYc2u
 gmWT2y3i3E9gPvYUe0Kx+MazxVLwZLmf6eualodn5DM/emgJLCTCd7QW5vav07xi
 iOATW9leyczS6v87S1eGUNRpNERV0ustiixZ8IVpN2NaU5xfCjzDSPTnRxIOxF2l
 5LlA9s6XknAGXjoTr/Ixk8A8vT93rlikpMMaDKxtqVZOlkWiyZSJTh7IaESZ40a3
 7D+/c24/LzIY226thjPW0Dz7N9iHYXxw7ySRbpujH6T6Aq9aiaV/8UqhJ+lWUkFQ
 OSb6gg==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eattq94e3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 22:40:01 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-132d631edaaso46059855c88.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 15:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779489600; x=1780094400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bpg/MoP4gnTWpwVj56a6cJRGbDZixhfx1+1Z8YVR5Xw=;
 b=f+PPlhm+WNY410hUOCxWLRwTVRjQm8Ky4QAnVXO92bO8HfZpCyrykvqf6smptnv4gf
 tMi6f+wEp26A7ZGHn+ZBCyCDynnabAPyxumjSt7SvuH2uZfH76wC54OFRVrbJdMGPOTG
 7F43EtCYqkQruUfgQHrqwI6DoK8PFaJi5IspeT1orNE96KaOcqaj65S7yPFqrZ5y7wE2
 Xq/Tb4YENt9CRsl29gAZMdtcps9xhtsQhljNRiqBEzRdUY2IcAOiFxMlBY8LhqncORel
 Ugaek+DuWqu0KfJcHuKO+xSPzWhBGsfhJ09PgpKy8uw8iAqaPh178sNcg0LgS+/7iYWC
 Orqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779489600; x=1780094400;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bpg/MoP4gnTWpwVj56a6cJRGbDZixhfx1+1Z8YVR5Xw=;
 b=NCv1IjeLg/52iDqReJB7ZMn4x5gCXcPyD71WEbVKr3T2Q3DR4R3bO5fVdeDcKYbExK
 3l8GB3IG0A030Va7L6krmW1WNf5VTcSh4pgtByG9HLV8KI2QYYIwiCLIJJSoX/WCSsvX
 InEXWlwlMop5Ki8UkhLriU5WYDTEiGcEBtIHwe80Q+dKD//7Y82EvoohxYhx96P7OBBU
 RUo9f45L8ooZxtB9a0i4iZKKLDTzJn4hr5rgB8F5TYZQvsE9xLmCJNEIXQ2mEJKOZ5SS
 WrGs3asK39vPIK4qHueeUUjLYqUIoQ/4Bou1QqRhF/SCA67lojBwi+5EMjczgbaOtPTE
 Sy4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Co0LUiffPeb7VVwGrriPK0CZnwbhIPhjxMJZwNWeIjxqTahNjDscx9mhRb5Mq0cT8e8lsc6T5SH1E@nongnu.org
X-Gm-Message-State: AOJu0YwcNASS6DyE9dY7IJvAiH0Y1DpTqtqXiYjmg3NyqPNh42Zm6DSL
 T91hP8sertPJ5YKBgMhc6JPzO/heZDSTkfeocMXiMXaSHV/Eyqk0UK4YpzMvRy0j2w45EGKDYuG
 CG5NKviFc6Hka4bfpAl6kqZkgo43tkrHVg4zvafE8GVUl6ODG/BzCXyA6vQ==
X-Gm-Gg: Acq92OGfTa6iywGLXd0PgXLLAC20SSHxG9CK+ON3lRy1O187ZcBWucmkk6IQYlDJUuF
 9cpENM6qlPfEP3tSGiCOi5BaUHLP2sRYYkdntZ/JwHWzONPH9FPA/HfcbJFe9O8HrP/eFm4H4KV
 WjOGmvdp/62ENCcH2cNFUNG8pHg7eOPFRiIDXPCh2To7MXzoZDNhKX+UKiPdiPrkfmQZ+ABoxaf
 3PTH5rUGD3P+7+xS2Oe9bGBX1oSjF79DvqZIXeELD2XPw/+RJNXwiXpCGSWQgIOCgOZ6jj5MFiK
 r27O++n3g+sR7YyNesQBrlYcJmBTlhdLeaYf14X6E9Qtodim6LW9H8GHGcYJpvu+1X6NcltipzJ
 +DF4VqYKxri8vxiiiq8QR9E2c2xo8DT+k/3bhV/ND9aoGx8hgoLIn5/vKbPKWxPwaBdaVwHA5yY
 GVwe+rIbKHpEExew==
X-Received: by 2002:a05:701b:4241:20b0:12d:ce36:8930 with SMTP id
 a92af1059eb24-1365f8106b9mr1768791c88.3.1779489600187; 
 Fri, 22 May 2026 15:40:00 -0700 (PDT)
X-Received: by 2002:a05:701b:4241:20b0:12d:ce36:8930 with SMTP id
 a92af1059eb24-1365f8106b9mr1768780c88.3.1779489599594; 
 Fri, 22 May 2026 15:39:59 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1366aa88c7esm1849981c88.10.2026.05.22.15.39.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 15:39:59 -0700 (PDT)
Message-ID: <2dd1e3c8-1e12-420e-81d0-d394d2050fa8@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:39:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/37] bsd-user: Add bsd-signal.h with sigaction
 through sigreturn
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Jessica Clarke <jrtc27@jrtc27.com>, =?UTF-8?Q?Mika=C3=ABl_Urankar?=
 <mikael.urankar@gmail.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
 <20260518-misc-2026q2-v2-3-6c16fe448301@bsdimp.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518-misc-2026q2-v2-3-6c16fe448301@bsdimp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDIyNSBTYWx0ZWRfXyWztQy8ru4iG
 FtKN1NjYZF1HJH5uG7e84N36LCfhzrMoBB2J12nLpohBYzn5IycoWs1iNUia4f3NVt0oRYZmbC0
 WgsxOBBHwmxGg3U8AHHFHSPC5zViw5VDQrRbKBl2an0FAvYtzC7zVhTEvpIZ/7z40vXxR6etpJb
 sZyeOZzB7e/TI+ATzkipAL+IDZO4tx2BEP0yBn2kV4syRy1WbDpKwmwSoe2dXQue0/5O+JkJ3p7
 WmpFL/yP/Wv26T5dbLLn2q5bkVyAGKB2sleSQaIuM00qsiv0dZTXoYniXqEJJbJ//ede1d2QWLD
 1HXJmhxkJeri96qhHCX0Y4D8fJgRmQUmUP39h5ml1HhqU0LSbebvMWNAazXL0BoPnOcjjiV9Qz+
 WlukDyuZ8XBnIs85QBfJF0h4KuNHmA+YLPzw9c9RXBhPjIzEyvFBZWyr/hx99I62H1WWm/5Do2W
 qahj1bkDwfXE+Pe0Q0A==
X-Proofpoint-GUID: Q1JfhF9j9Xy-A5sULtB5ggiB4R5ybfYj
X-Proofpoint-ORIG-GUID: Q1JfhF9j9Xy-A5sULtB5ggiB4R5ybfYj
X-Authority-Analysis: v=2.4 cv=S/zpBosP c=1 sm=1 tr=0 ts=6a10db41 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=6I5d2MoRAAAA:8 a=j6bprNooAAAA:8 a=pGLkceISAAAA:8 a=7Qk2ozbKAAAA:8
 a=EUspDBNiAAAA:8 a=F_AVDILdZqRBnJQxlSgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=fS_Hu1hw59wj44055X5l:22 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220225
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

On 5/18/2026 2:27 PM, Warner Losh wrote:
> Add the first set of signal-related system call shims: sigaction,
> sigprocmask, sigpending, sigsuspend, and sigreturn. Also add the
> do_sigprocmask and target_to_host_sigevent helper functions to signal.c
> and their declarations to signal-common.h.
> 
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> Signed-off-by: Mikaël Urankar <mikael.urankar@gmail.com>
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Assisted-by: Claude Opus 4.6 (1M context)
> ---
>  bsd-user/bsd-signal.h         | 151 ++++++++++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |   1 +
>  bsd-user/signal-common.h      |   4 ++
>  bsd-user/signal.c             |  67 +++++++++++++++++++
>  4 files changed, 223 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

