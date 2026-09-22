Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B43E8C982F1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8sDM-0004bd-RT; Tue, 22 Sep 2026 00:34:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8sDL-0004bV-5E
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:34:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8sDJ-0005oZ-EO
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:34:42 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M0eY5B3044076
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:34:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IAomeNrXxw/400tSQYSvGvN7FhUw7IvH52fcRE+CwTA=; b=mY/aBy2cwrPFfOcJ
 fqnFhIGr9cfMTg8IB7nISotr2pbZ2oi3rXJoORwZSmcrpYhnsB4PKFs/NVQ76C5o
 mnLKpXRqRzs/t3ELoqYeUS5IZ6+WfjHAtn2P5FyYLHxUvCjFa2QO4PGIiuBpECLN
 w7OR/0a30D60hr1nEPqM0SwJsDXnywZXE8PbZj3svvfqC27/KHNKetO0sN/llJZW
 8hcey0BmYxIZNhuiqScMBqz6lTrdc00EJwoIcF++e+MJTR0EHtZCz/cf4zsCWfwI
 R5ejI2qFCfmuzIh4p6w55ILjK6IT+dZprpADvOYdORPcLK2A3/hkonIBeFBHKkJd
 t7MqDg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gufbarqqh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:34:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a1b824e84so751316085a.2
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 21:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790051675; x=1790656475; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IAomeNrXxw/400tSQYSvGvN7FhUw7IvH52fcRE+CwTA=;
 b=aL+WW+TpBwPWI5Hnl/UmVO8wwGMCYbet+JOoYCFd3o9EQP9SlX/2hl0ISZM1yndkmD
 s1ONoAa9v44Sz/gm2Y90wEQ3HzR0bhQNaRFmgdSlGv7SezvHSkYEo7KiLR1/WVskvRr+
 0MGZ8DfS+LCo5oGl4mbJv59+v8WJ157s8cqPUPP9p8g73/pTyoRSmdNkn1MKf2ObQ0pA
 T3vVNuSc5YInUkIC3pl53uxy27zVTmJ63gJkKx4vABw/I0euCwJrwonEBqo9I1wweWfb
 i3oXHC8Ctgm5u1F7lbBC8monnuvfbkJVfGSdI/ZfeuAGgNrG+GB6kRmWJhUykEiiS1G9
 uzEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790051675; x=1790656475;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IAomeNrXxw/400tSQYSvGvN7FhUw7IvH52fcRE+CwTA=;
 b=OWBadpByEXi4HBs3v5GlhwE6DOWdc/x5RRDruSrDlsEeGauNP6zrnOfqND2Z9D2dsg
 9CNYGJg3TyYGQIwh6WdbObRNV22D6M0PKMM5GpOSfQIz4XDz5VfCCfKvUzvEKzcZuamc
 hnejN5nihc1sCizu+vmKoCw2Pgwpfkrk0Pp4vj2CDC7c9y8rK004X47KfnskhdJ5OvP+
 121TFZxQIBYYf51OBfUsaq+VCJ0R0SyqUHvSFksNl7GiBXfJQVv9S8mPfMczeIrSkcsF
 ymD3fMmMIFUZolL/Axc9e7rjeQ+VOvXF5hybBIwy5mQDrYC4tj76M2K8c38GfHD4wti3
 +LHQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwW2uBAeEnp1PzRiqQb3Rfat3EOa9ES8YzNy4xJXeRIBMHlB8DpXyv1jsB+c1AqU3KTeJ7RykHi293k@nongnu.org
X-Gm-Message-State: AFuF++kBRhYOi97C1gEJSun+UyjEhN/oiHi0G0HbVHkhB10ZULcKdryh
 VabbWvjgh+AZqhk+7qsxT0HK/jHbjof7a9Km465eci6FdYZT0qxy+Hf//rUwNKDmJMxefWDi9eM
 HnzoxDSfWwktKfpFhroAL9Yh02tmQv7LnzRKKThYrZ8XEnMTnvkihKma/DOfXF5qyNA==
X-Gm-Gg: AYBFou39N+uGgArcVywskMdIkuSgaK0tZT0jecq74oeX6xNkjkXlvoAmPMN5YCsT2/h
 5vi9oheTCnefzl72WkuoYhZcrcxJzxSONPihRcVThlf3ZE3RqNT93VA6Y/iho6vhQJahvMD2DgM
 a6ibzraTpDa+22R/9Jdu31HeXyki+6EpU0EFbYc1vn1pfGgz8tE3kzj5fRMxE7FIwFHgZF1+qHQ
 qmZZH2uKiD/oXoBsPoLwS8FqO7OJtI02L6FSjedfeKpCdnwOwRs5bsQ8QflJ2Ewgl5VX/vy/B9d
 LIE2pccSbAsgu9SHPf9vxJkjBf6EhM+t0ymE9i8hCkChUjrLrEOIV6T3gi9pGrJZbfuWrzLeb7Q
 A0kfP5NNDbeYHWK7ELqdIISsf42Z+BF3LKA==
X-Received: by 2002:a05:620a:bca:b0:93a:252:705b with SMTP id
 af79cd13be357-93c15da2627mr389090885a.23.1790051674926; 
 Mon, 21 Sep 2026 21:34:34 -0700 (PDT)
X-Received: by 2002:a05:620a:bca:b0:93a:252:705b with SMTP id
 af79cd13be357-93c15da2627mr389088685a.23.1790051674494; 
 Mon, 21 Sep 2026 21:34:34 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdace76e8sm24972755e9.1.2026.09.21.21.34.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 21:34:33 -0700 (PDT)
Message-ID: <80b963e6-2a16-4a9d-b544-384a6eeb3b86@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 06:34:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] tests/tcg/meson.build: force use of linux/amd64
 platform for containers
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921231458.3369-2-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921231458.3369-2-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2MyBTYWx0ZWRfXzzob+CQ/LuJN
 Lph8ed3fy1aFn0scgaBd/hw6M+D32EJ67NNZVjTaCGitxcqkPzThtzr+0d/2g3wAhVNM14HIXPi
 CMLcnOGI++z3dk7JZAq5DxFzfKpI7HZqCKpcyKWGlFa1oSgDORJfT6ocZm7A9Zb0lkgrYM9elYQ
 EsqhfsQ4LCsC0sKxEygnwBZUsqX9K2WKU6EN9Fkk9Fb59eXvy3CxWz6bBQJN+Hdp5WDUM9d4nx2
 nv4KL1LqTsNHQnjgdCHsvheTXmVOwlfVNLrL3IQPMZ52PDvxGoPZruN6j3pb8pdM+1WuKnU6g9Y
 wYEqVFrgp0NVCmjMwXPk04chDwGpJ+meH68zdMoOQQeTxYh//7fNCuvGIpZWm6PLtVovCDEJH3f
 GOFIBztPw7TPtPx9jFADUpvBx9J0poV/jEkUkqbWKNgcp2jyZXsDF6+7bcPDHR5gejH6fzD7bJr
 akXr97qJ+HOs5sIZPFg==
X-Authority-Analysis: v=2.4 cv=IYYSymqa c=1 sm=1 tr=0 ts=6ab2055e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2MyBTYWx0ZWRfX4cx44oxkLFYN
 b95QLgdOeQ0Ce6TK448n1uAExpUQSARm0cHJT5WcoFlnSSjaBT6LipVgYeIJbET8HCyDn1160yZ
 b23ApkwlLs8CCU0q1sb5zW+K0G2Q2vY=
X-Proofpoint-ORIG-GUID: zkouRUkQlMviAcRIs86Qos7uk1vy07Z6
X-Proofpoint-GUID: zkouRUkQlMviAcRIs86Qos7uk1vy07Z6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220063
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

On 22/9/26 01:14, Pierrick Bouvier wrote:
> On hosts != x64_64, we detect if host can run amd64 containers (usually
> through qemu-user-binfmt). If not, we deactivate container support.
> 
> We could technically stop here and force container engine to use this
> platform. Since existing base image (docker.io/library/debian:13-slim)
> is multi platforms, container engine will enable this variant by
> default.
> 
> Now the problem is that if user reuses this image for their own
> Dockerfiles, they will run into unpleasant surprise that now, their
> container engine is using x86_64 variant by default, on any host.
> 
> So, in next commit, we'll change base image we use to x86_64 variant,
> which has a single platform: linux/amd64. This ensures we don't generate
> any unwanted side effect when building our images.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/meson.build | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

