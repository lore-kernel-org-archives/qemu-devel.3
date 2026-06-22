Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478A9CDB466
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 20:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wblO1-0000Ts-WB; Mon, 22 Jun 2026 16:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblNx-0000Rj-TI
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:36:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wblNw-0002b4-7j
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 16:36:49 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJaDUg2101410
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 20:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sS7nnWBpxw4wPxwmJtSD9Q5CteSE5Q45qdQa9zKP5Ng=; b=E4+voFBwnCNxNSuY
 mF0b2LS5iQAQ2Z8ZH4pqZnR9EY0S8v8E9tjSHORzS6a7AmTmzVC5B0Cepyyw8aVj
 Tp2F7Un7KQZHoeiMtTpLR8V5GFUuvPlA5ccOcwaBPQBYJvFyG51jwQE+I9uhQpsj
 ONci9SkMjpFuPoGKzwTb8KNJs7sxxrNsUB45ex2hD+i02hJ3rmnyuPQ8eK9BjBlh
 X1GyhU6RcGuXbpz4EvYP34cqzMPq96CExRr0p9n5/6VDAIoHJMSDfq6d0axUkec6
 HMvTfppAxTqLp1g/TviDkjBrjMGGfIBJ/6KyAQh7H+ynWmB+a16UIqiZ69vMvj1O
 QW+Tew==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3eba3x0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 20:36:46 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6cfe512e871so3654779137.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 13:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782160605; x=1782765405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sS7nnWBpxw4wPxwmJtSD9Q5CteSE5Q45qdQa9zKP5Ng=;
 b=TfY3YIIal/fy4bIONQv3gS70mVxcHyORKb0716RE7Q7QLsTtCHJeyvfG5+xAbjgG4c
 87gPymhkjGhDeJhmugFNNwqOIu6EYvZuCbOEwhXh6oyYR1BsMIQY5XjiuyE9E+n4Lq5X
 JhipFdRm+VLEFA8Z3gdk2LAvzx6ffFmeDoghTbUnfR2Rq6gTDG94UNc49ykvWadeRKj7
 3J6/fSjSFcr4aXwMgGYXA5fIevwBCoMn5LGKn3Y4xIe7Ntt+ttQYqvAiKm4miIj3a412
 3B4oZwmD6Gy6HcVNhhafnGCkmUMEMD2kCu6RHoSxljGVUOXvFFxN0KxlXG+nEl1mizgX
 4AiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782160605; x=1782765405;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sS7nnWBpxw4wPxwmJtSD9Q5CteSE5Q45qdQa9zKP5Ng=;
 b=ZD1F6299tpomy347iBfM2ehEQOjlaomDrXii02/iTFaHdTi4phLjAPJO/cuwOk/sbf
 9CL7RUOBglFZ+SEy5JnJdCC8wOo0JjYmb7MDzNfB2JkYN96YTsefrMPX+5zOVpmrf0xb
 TdqV6R8WeuAO9Ydjq0NFNUw7SKYCVRDq1BN47j/YKq9H5kvyS5QLT1Lvvh7mWhLPlVVc
 tcfMgHdNbDF3p1igbVUgyru+88mlPIKOypA7GCCbuvNDPT7oEtkKID+F8JY1OzB4wefL
 GH578VUFKnhn7A71b/UDTh3eK0OqOaJEqkmE9WhTq4lzlRazNB1DGQhUlI6F8fxu8lQG
 MDzg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YhPSc5PcDNGFFF0bTodeYofhPafe7ktGcM1Jl7hJwdks0bRm6KQztkggIeXcaa3G/vVJepn49e+R5@nongnu.org
X-Gm-Message-State: AOJu0Yxliur4PuxYGbiZhBgTd5vHEWDIsB7TsZQ8s4M227o29i5FTG6r
 MpXAdL8ja4gQeiCiO5Mx/hYQd6JoGzk66pJoy5gxorgVEUFotSCjkDZRu1Sxw2J7joAO7A8zPU2
 GFt2b5vvRe5Bnh379++U5tmGDWb54j2M6BhxfIOXQsYxEOMlKlZWAM0NB/w==
X-Gm-Gg: AfdE7ckfukfMwvmJW5P4WiBZjlgNu3WgKNfMVNeeGnM7Lh4tQrgEIPWPY3t7kfU53jL
 wBaDh21uDtleU9w2Tn3Z6eeYBIQeS0gVqjAO16CTQ0M26DaFNIt7RzI+Re1W3wdpTW3YspLJ4zd
 JcOKOy1XrDHq4QbQGrfWvbv8TXzteLRLpvgqQ4W0tRXseS5gOmHoRQo/lduame9nPq95KNhI+VY
 3hwUd9z7Jjq1jEfuP9o2bwUC7nP2hDS1JjZw5FidS7aYHjfDOvyJiZBFEnKhmfhY/zHH1hjTLJ/
 mOIQYaGpj+B9BOdDM8Y/xTwup0Hb9aCVFTuoyw0pPUJyigIBTUAiGO0LLNAD3arQDC4dUsTZwTi
 VQxpFoqNJ+lCxc33/MBxAHsDuK4ZTSqPsqJ4vDZ+kSOUriu3r2cpVbEbhnQ1nMA==
X-Received: by 2002:a05:6102:358e:b0:6e0:3d72:3044 with SMTP id
 ada2fe7eead31-72a791d459emr9480230137.28.1782160605478; 
 Mon, 22 Jun 2026 13:36:45 -0700 (PDT)
X-Received: by 2002:a05:6102:358e:b0:6e0:3d72:3044 with SMTP id
 ada2fe7eead31-72a791d459emr9480205137.28.1782160604938; 
 Mon, 22 Jun 2026 13:36:44 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666c57b95sm26340486f8f.30.2026.06.22.13.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jun 2026 13:36:44 -0700 (PDT)
Message-ID: <55d966a8-7698-421a-8265-2235d5fe104a@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 22:36:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] MAINTAINERS: record known Git Lab handles for all
 maintainers
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20260622113152.1710585-1-berrange@redhat.com>
 <20260622113152.1710585-3-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260622113152.1710585-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE5OSBTYWx0ZWRfX2BaPFJ7rbXsF
 dDD0DWS8YWdEJNOCOWXiFKDn2xT1ikRgi4YnOZ2wDpMCecXmVem0aChx4VrvjeZeJ8TIvOOLJoM
 5SjG7tK19cnyr26R2BssoIps313VhVY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE5OSBTYWx0ZWRfXyK62zc4DRXPa
 zM1T32H2azPhmkz6bfj3Fdi7l5xxCbfYfJ66mKRsCDjTzHk93NSRh0yM802Sn4/VkpXByJ4C2aG
 GNzVz+k0RdletAHsQJBqRkO6fkGBqjlUytrKaCCnJ6qVuGsxtdIItMJnXHY7PqmvBcq6h+SfoRX
 g5uIPhPkwbao9iEmYfVwTgcTs9mSyClIcNYXJcs2hNqt9Eb0X3mk1z3yutRtWX9Ocs6bTkRo8fZ
 zIUmkyer/kvmfMVOPxexuvkoXT3ZTfal1hZR31WUCE++iRvVKJorL/fnKlPdfi3RJNlNofeoJDD
 mlcXQtyCoi00d0/W1jLqgwo/RqtRQeQBxL5o6VqFCraa5KfZ35KkWO52ynjyokmQGQoQwyPNage
 TM9zSVCh6RpOwHmGB7YL9jJj+sP+xVLyiMd/Rgtr7/qhOfXAilekrHEGG/I9ICJnvt3TUSZ8EUd
 sbcuL7Uzz+OCYjp1F2Q==
X-Authority-Analysis: v=2.4 cv=ILIyzAvG c=1 sm=1 tr=0 ts=6a399cde cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=ID6ng7r3AAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=69wJf7TsAAAA:8 a=9qUTvQc-AAAA:8 a=cplnpDx6AAAA:8 a=UpeuL96urPyQuuX98vsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
 a=AkheI1RvQwOzcTXhi5f4:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
 a=axOgMmt4Ejcwn1cqzmsR:22 a=bHwCOBSOUrNypjIvOSWD:22
X-Proofpoint-GUID: oBYIL25YqP8mGHhxTLjJlE6urxJB3AkG
X-Proofpoint-ORIG-GUID: oBYIL25YqP8mGHhxTLjJlE6urxJB3AkG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220199
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

Hi Daniel,

On 22/6/26 13:31, Daniel P. BerrangÃ© wrote:
> This updates MAINTAINERS with a "G:" line corresponding to every
> "M:" line that can be identified with a match against
> 
>    https://gitlab.com/qemu-project/qemu/-/project_members
> 
> This update was done using a largely automated process based on
> the data extracted with
> 
>    $ glab api --paginate /projects/qemu-project%2fqemu/members | jq -c '.[] | {username, name}'
>    $ glab api --paginate /groups/qemu-project/members | jq -c '.[] | {username, name}'
> 
> Some Git Lab accounts had real names that didn't have an exact
> match in MAINTAINERS so the glab api data was manually pre-processed
> to change those names.
> 
> A Perl script was then used to insert "G:" lines for every "M:"
> lines.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   MAINTAINERS | 332 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 332 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93df53d87f..9a62fe0e81 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18,6 +18,13 @@ Descriptions of section entries:
>   	   These reviewers should be CCed on patches.
>   	   Reviewers are familiar with the subject matter and provide feedback
>   	   even though they are not maintainers.
> +	G: Git Lab handle to assign issues to: @GitLabHandle

"GitLab"

> +	   Maintainers must have a Git Lab handle listed. The handle will
> +	   be invited to be a member of https://gitlab.com/qemu-project/qemu
> +	   with the "Reporter" role. This will enable triage actions, issue
> +	   assignment, and visibilityof confidential security disclosures.

"visibility of"

> +	   Designated reviewers may also be listed at the discretion of the
> +	   maintainer.
>   	L: Mailing list that is relevant to this area
>   	   These lists should be CCed on patches.
>   	W: Web-page with status/info
> @@ -58,6 +65,7 @@ Descriptions of section entries:
>   General Project Administration
>   ------------------------------
>   M: Peter Maydell <peter.maydell@linaro.org>
> +G: @pm215
>   
>   All patches CC here
>   L: qemu-devel@nongnu.org
> @@ -84,13 +92,16 @@ Responsible Disclosure, Reporting Security Issues
>   -------------------------------------------------
>   W: https://wiki.qemu.org/SecurityProcess
>   M: Michael S. Tsirkin <mst@redhat.com>
> +G: @mstredhat
>   L: qemu-security@nongnu.org
>   
>   Trivial patches
>   ---------------
>   Trivial patches
>   M: Michael Tokarev <mjt@tls.msk.ru>
> +G: @mjt0k
>   M: Laurent Vivier <laurent@vivier.eu>
> +G: @lvivier
>   S: Maintained
>   L: qemu-trivial@nongnu.org
>   K: ^Subject:.*(?i)trivial

This is an approach, and it does the job, but I'm worried about its
maintainability. Since there is 1 handle per email, what about a
.gitlabmap similar to .mailmap, a key:value mail:gitlab handle?


