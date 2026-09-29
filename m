Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BD0CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWka-0007ut-18; Tue, 29 Sep 2026 08:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWkG-0007hQ-Hg
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:15:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWkF-0002sA-3t
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:15:40 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCEA5l773254
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HDyUKxMk6fdjXc4X5OTsagT2rKmRNnJMdTJIJSeFuQA=; b=cURpSJFbNX7m4mXd
 PJ470Dw2B86SShvqO9XSwTcuFzLqzw+8F/Ywt2ocpuQNKQ4vT4xqWsl/LAivOhxq
 bJq59lgO0ynkqBz99rwHHSlcIeuoq0lH+uAQ0QlDNJAacig1CWISBO5TQfgIMEjP
 7wV8yioyhPmKqeBFahv2tj902xR+cigweqIHQslbE7kZJRWobscvUAVFkEwuzuLr
 WBNh/JOhnhVO7UZnLDIZXqoEjwCWNJBwK7j2kt7+mQlO3OLPGQEAB+D9q1SGFLDg
 i/z9Qocj/B7cmdAS2mf7B2vE9x3g1pqUvI+Wz5NvP7s4HvHo91Z2yzliEp/8v8tI
 axmNnw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h08e0hatp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:15:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934956beec8so873190185a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790684137; x=1791288937; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HDyUKxMk6fdjXc4X5OTsagT2rKmRNnJMdTJIJSeFuQA=;
 b=aFdR1NXtl/3+HfhPAq0yAv3jMda4hGVeciz+M210G1WTsBx7pFEh2Vs/zZ2r3gRFNV
 i0hL67VW4TJ4rxwkUyyp4FzYXzEvJEUYWVVuiyQ5UiHWY1Wa0PiE517kYR5kkr7rZ73+
 fj0o8mvWQ8GppEcyLOlIlRVDWHKiUp1ecNmUawGNy0mXE1TVjsGaKZr+uysXv/KB5Stf
 hTMFVAfuzLS+Yz6nYMzoCEFXdJKNEEsxCBt/LMA3RmQhiWWQLNOV13YUhVw6V73/Wo0m
 ehuangk3lQtCnk+MrKnRdWD5/nad3bzMGA4MSwxBEDnK7ZRxde3Z3La0thQ8KmO3L7qk
 a9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790684137; x=1791288937;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HDyUKxMk6fdjXc4X5OTsagT2rKmRNnJMdTJIJSeFuQA=;
 b=wKCcIRwbzQW7uCxE9gEpuDeSF3HiGIwoE6jDYsIvOohaFDaqGXSk44gYtKewI2Zrhu
 Qc9iIo7xtMv2kNAqGkQZzuNocHn7EYa9OuQsllFj6mniipsHojA6xe6afXva6rjCWXOY
 U6klNSnRjX9P7s0wUNZLtDil2wS7ihda7s2qrxj6awGPRtlJJZxKNcKU5HipGXziGs26
 ppOUh5mm0cvj2Zrben2hbxp+DWKemHCse8BiULFjGp2Tgm5XWGBxskKzga7svFt8eQWI
 KGpgYfM22hfousptKbWEgIn+E7V8qZrEdIXd+tig+8I5IKWn+Qrxb0zwU9CKIFFngbx+
 6YGQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKAJgDDL9bqgbglvlnhIghMzYxYDty+rp0qDLcH5K2TAqtK2DA/pF2tzXGH09O0ZYKMrMkuMU1f4Uw@nongnu.org
X-Gm-Message-State: AFuF++lZ1hkRf7UxXABrnEFJJM2sdyaqqVdJp0KKz6CX55xFGcQVTDpy
 3GvH8u5h1OQlln/PEY2lHyRvvnSZuOGJP1nuNAO0eYTjM/ZD4o447U6ir0kUng91m7oigJSw5Jn
 O8V12mSIGDB0+bMlGDH1AlW0yIn0war/bsyeccvMkzGePtoC6iJ/pBo+fTw==
X-Gm-Gg: AYBFou2odLnEud9vCaqYP18pekVJ7aUykUi6WVeINVIlLrRHmXxKcHMUV5sFucsyjEi
 IeMYIrNw+P6P518ZfkvikBbPx/i9Kdpl79myR/WdZ3nmyxpIZBPpDNG+ZPvOauTer3HetoHSeoP
 7KZdK+6ELUhcaqqTRyRAHOeqaLuSA5tUib4MwbgHlWZ81oXPh4g7rsWKqnE4pZuS2AvywEvvftn
 pu9xEBILMHWj5+4d0CIYvI2H2Zk9ZPlzKAAhGr18zrG+Csi6sb5CE5OMvxzOSZNo7lGBQ3q9hCN
 hmhcZL7c8I0IGU40PMGim72JZPc9SG5khD27+tGvDbWErHEuJ2OOlSG2c7LjGjGdL4F+bdipL57
 5HYvQe6MTzaCre9i0cH0SRmE98mp9cP3Grg==
X-Received: by 2002:a05:620a:404d:b0:912:1206:ddd1 with SMTP id
 af79cd13be357-93c43b8339fmr2537125585a.1.1790684137232; 
 Tue, 29 Sep 2026 05:15:37 -0700 (PDT)
X-Received: by 2002:a05:620a:404d:b0:912:1206:ddd1 with SMTP id
 af79cd13be357-93c43b8339fmr2537115985a.1.1790684136462; 
 Tue, 29 Sep 2026 05:15:36 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af50923f0sm3690295f8f.31.2026.09.29.05.15.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:15:35 -0700 (PDT)
Message-ID: <3dfafd8e-2316-4c38-b87c-9bcce4e06f2a@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/42] docs, tests/functional: Drop redundant CLI
 arguments in imx8m*-evk invocations
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
 <20260921214710.29422-6-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921214710.29422-6-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX6ZUkTJBn4Js9
 1FBTHVaL+bbK2dWo+N8Lj0I6t5B5rNg12aUQSqyWuHIp8A6xSjRPD5oxGeb4tjXMBkNvwiYHmYm
 FzRxjS+HMMYJ2W5F92r1Xbwy7hkZV/A=
X-Proofpoint-ORIG-GUID: FQJxbL91NlEi39vdT_XyeE8cPVvxf0x9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OCBTYWx0ZWRfX+ipTpBLpz4sW
 WT74zjQoLMf20bOhSuOUhsmyep08PK+RlOavkPWbevVq8AU1p0rCVkbd8Kk3cEE2D87LkxnnBy5
 iU+mZJYL3CEX5BWcRlzBC2lMNeMJChh42oQXkg8XFq03B4EbcC6Wx7sZLQ8ajgMACxatxLR9M5i
 6s3NE7vfAWoryaVKPAa5gJIzfvP7rfjkuN8CK5tgg4aghzZOKnGNy223gcpaNecIDamUc79Xv22
 dXLHTQjUE000jeNPyhdH+Y+jp7DEctFVTj5Fab6v2GEPm/wD03JuBNTb5XLwAVpM74dDbyBbvSC
 +86kAVScx/YUFh4CLQTBvCY46JM3ux5vC7tZuRcdgriOsXwwBossmeltqq3rXzxHOK3otGpLRfz
 Rwxlabl7CPDHRSmgOvBLoSBz1w2Tr+m1ftPFOuvzFg9PJE5u+gbOJFDTjimhKDu5Rti6/tauX/D
 jN9vxe8MBNPUXJjgsaQ==
X-Authority-Analysis: v=2.4 cv=WJ7qzXsR c=1 sm=1 tr=0 ts=6abbabea cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: FQJxbL91NlEi39vdT_XyeE8cPVvxf0x9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290048
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 21/9/26 23:46, Bernhard Beschow wrote:
> Both boards provide defaults matching real hardware. No need to ask
> users to repeat these. Also, remove these redundant arguments from the
> functional tests such that the defaults get tested.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   docs/system/arm/imx8m.rst                   | 2 +-
>   tests/functional/aarch64/test_imx8mm_evk.py | 4 +---
>   tests/functional/aarch64/test_imx8mp_evk.py | 4 +---
>   3 files changed, 3 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

