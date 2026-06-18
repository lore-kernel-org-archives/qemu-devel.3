Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1C4CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waDPR-0006Lc-5W; Thu, 18 Jun 2026 10:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waDPN-0006If-Q5
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:07:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waDPK-0004jQ-Od
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:07:52 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IDrQnC1331439
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 14:07:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pzoCBD3pfKjxxQsERpGWODFVEcvENVkfk5UacIRzp40=; b=NtvM7mTYNL4Qed5q
 R2XoCcTjCcJlTGDHXVTIfmGPqha1A5S8xLjA3nppn8GNQPhbYxGWcQiBAvHvDLwB
 CIaYEXhWmKaBkH3/PLQDBXVtb01oRnQYNQX6mz5HJJqRoJs3sthrTJgjQ4VRS8EE
 msNZn7m0pW7tMgLpu6y4z3gYv6tvNa/ntg/jJGAvYcS1zStXIWKu7nEtmyiQ2ZRp
 N3pwfBMat0VECi22mbqvVik9rCFYpf42IaJWJmq2bdyMiAKsEjyvbuC9xBGc6UYn
 LX49eQy8s6Na4/xm6BCPYcQOcb5MwukLQLUetEpDpcMK4c1fz3S5zJGCktisdllK
 P6idYw==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4euxt54hh4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 14:07:48 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e713779405so1807622a34.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781791667; x=1782396467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pzoCBD3pfKjxxQsERpGWODFVEcvENVkfk5UacIRzp40=;
 b=KqXqZ2TNkIX5rbz5HKYvqRSLVsXtBoNkVWkK7gTn5++R10KZrdq7HWVsaKgqkggbnK
 V0sAdWI/Sjz2s2OJdn7E3Bg8gg5xy9RuXwyvs2DCL2bj5DwGuQSxBdIsTAS+7uNry6Ax
 Mt7vrqgKCo3DcWbb55UO0txNAmvHQjaVmRqEuRWB0sCNDUha9UDqRTchs3FWxNIV2mJ5
 Oo9BKuvgJhbRzmk79UBOCFj3sqo8dWeDi2/XXdCpcCNS2U4YCa9hkHlQJzBlGVxOH+8b
 sBgn6xibQ+jQGLITv4PWoAWC+2qhiolqnL1+B1WQcZ3wOm8ObpCmj3vL5to508y0WY6J
 DPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781791667; x=1782396467;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pzoCBD3pfKjxxQsERpGWODFVEcvENVkfk5UacIRzp40=;
 b=YEnJ2sFpkuv0JWNeqkALqU9Q9VdKpE4mcDUZll6iyDj9K9qpR+jfiXT6Rz703BLD90
 hHe/WPrIhePi2+cMTxiPvC79D+2CH79Y+KwpYSZWeVzV4UAmeTr5MpPCuN0rWMNuRX9W
 0gNp8usayA+2XHz7ogVotuJtb48CaFBQqRMGZ5JiZy2jury3d/pUK4mg9vff5Q0/adwI
 Sox8FtfI+uIap99kefaABAwAqhhK3GU8jcd27M0VmDZkeMY8wEeK9Gf3GM/dlAPinI3T
 7Ke03S+YrrqdpL1tjj8dnJUfd1NxKLE2BhiapVt40Suz1tzb7jQxep/ItmRxsDPxZokI
 TwmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EA2xUN4vWi5oIRxNpQHO+ChkxMtEmu4QVxyMizXbRRyNAXuSDe2OzWVucDvyqkKfafXYKikdjd5ar@nongnu.org
X-Gm-Message-State: AOJu0YxI0AL2cAtiSKrA/+LsdKt4KGdjI4px/g5xeN2YyQKteTWF300H
 EciMbOVdQ77yJMDaZPJOr3pDz5KHDkf2iJRHIXZjnvkGbZSs5IVDdTdxyB12D0uNnB5pjK08GJK
 WkVGeU9j7fCDeepnMWTTdlrprpGzasu3+erWV4ogcm+ti6+UCY89t/qqKvA==
X-Gm-Gg: Acq92OG+kJez9R3zwrvv9X3udx01BRqM1jLvCm+sRjWNCypooHMh6gzJmtaW1BW79Rh
 aClzqQ74f486OXHm3Fx06Ff4/ht1sKWaf+q2Ye6lwwoq8EGlmoftjymY84r3mZVVHwUWVo7cZOl
 TxOnufhujU/ptVZ+VxOrXbklqf0TYriElpPQqTl/wjPooip4NK6Ds7148XRCJJAzvil92o87OTm
 tRytQiJYZ/PB8aGLEZ7HcqGZsBWVlptq4ygvhmY17UTuH9r+KbskwgJ+wDaryXvDbgJAPI4V3Xk
 V+44NPQuJ6NvgG9U/s0Aur1W94uo7/FkNnd4VTuqCph1adIFXVdhCeTrUK+t3lSDUCYN+8EMp8H
 rM27r+yNn4wBcao25l03hEOmToDGto4uNwISqAE35rbnsY43qzYEPo4Jbrc2yvQ==
X-Received: by 2002:a05:6830:438c:b0:7dc:4a43:fb5c with SMTP id
 46e09a7af769-7e90b3b99e7mr8593188a34.11.1781791667232; 
 Thu, 18 Jun 2026 07:07:47 -0700 (PDT)
X-Received: by 2002:a05:6830:438c:b0:7dc:4a43:fb5c with SMTP id
 46e09a7af769-7e90b3b99e7mr8593147a34.11.1781791666815; 
 Thu, 18 Jun 2026 07:07:46 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2c473bsm68399138f8f.28.2026.06.18.07.07.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 07:07:45 -0700 (PDT)
Message-ID: <4420c1d2-0a4f-4a99-814e-f7b27a38b03c@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 16:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH v2 3/3] contribute: switch security process to
 gitlab confidential issues
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-4-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260618132058.1044341-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uiBUO26xcijE9fULRP85JJzJh-0yDuB3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEzMSBTYWx0ZWRfX6zNXNpITWHLi
 OL2PkEeket6X50qRExHtabxW56GV7bXMWl1ExjuXEw3E8FeBAro+tqAsVmbvUce7Cg4sQgFbsLJ
 mw9YPyvB7bapceDCVcU8GqU8CzAN85Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEzMSBTYWx0ZWRfXwRRZNZanKarJ
 qvkiyj0Vp/FCsnNvQlGqJDf3F8u3Ze/8DAhKc2k965Iitgp/5ebg+XRcFnPPg2ZcsYvZCTX7GI1
 Oc86ais1/VaH0QLktK3qY0ljULiBPgF+5EvQfos0Em8Sy8bjXUki3uh3FmBzcD4CCGPlyrsHq/D
 ECBT9+YaLb9gYFBFRTrvrVg2KHZYvcR3eK4Ei+AbcNyrJ+sM5s24VYu+kAcijaR6TUsTAQhbMpP
 da8ocfm/Cdx7De4XkFl0KpdyncQ2jkqIIqENQfgPiz7JHOLJkuY0+K5/U5UkqryRh+/wGHhS6XL
 FYYc7j2W2IdcUzGzFbaU6XeP+jGmBlyR71dIULzDY1FBdgYJekJ2SNCA1wkbjsqWzhuFq+MBFJ+
 VbrvsiuIIl4p2fq8oBEdKISCuBoDh2PgpZVlZTbN5aY7mqyTwY6VC/97NIZm6p46RvHbj3b73sy
 pYfz3xwBToTVA9Lz86Q==
X-Authority-Analysis: v=2.4 cv=PMw/P/qC c=1 sm=1 tr=0 ts=6a33fbb4 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=ID6ng7r3AAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=uQyPmvaSdCljYOczvzYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-ORIG-GUID: uiBUO26xcijE9fULRP85JJzJh-0yDuB3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180131
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 18/6/26 15:20, Daniel P. BerrangÃ© wrote:
> It is no longer viable to handle the incredible volumes of
> AI assisted security disclosures via email, nor are extended
> embargos practical or useful.
> 
> Remove all information about the current security process and
> instruct reporters to use 'confidential' issues. In contrast
> to the old highly restrictive "need to know" approach, the
> new approach makes all security issues visible to all QEMU
> maintainers immediately.
> 
> The focus is on making issues public as soon as possible with
> a viable patch. Co-ordinated disclosure will no longer be
> attempted and nor will requests to embargoes be accepted.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   contribute/report-a-bug.md     |   9 +-
>   contribute/security-process.md | 309 +++++++++++++++------------------
>   2 files changed, 148 insertions(+), 170 deletions(-)


> +**The QEMU project no longer accepts security issue disclosures via email.**
> +
> +New disclosures must follow the [report a bug](report-a-bug.html)
> +process to file a GitLab issue (work item) for each potential issue,
> +***marking it as "*confidential*" prior to submission.***
> +
> +Some important notes when disclosing potential security issues:
> +
> +* The QEMU project cannot provide an SLA for response to security
> +  disclosures, or any bug reports in general. Issues will be
> +  responded to at the discretion of maintainers, subject to their
> +  available time.
> +
> +* Attachments added to GitLab *confidential* issues are not themselves
> +  confidential. If someone knows the randomly generated URL for the
> +  attachment, they can view the content. Thus be careful where attachment
> +  URLs are shared, while the issue remains confidential.
> +
> +* All disclosures will eventually be made public. Thus the content
> +  or attachments for any issue must not contain data that the reporter
> +  considers to be sensitive / private.
> +
> +* Not all areas of QEMU are considered to provide a security
> +  boundary. Consult the [security guide](https://www.qemu.org/docs/master/system/security.html)
> +  for details on how QEMU classifies features.
> +
> +* If an issue affects a feature within the QEMU security boundary,
> +  but the reporter is unsure of the security implications, err on
> +  the side of caution and mark it as "*confidential*" initially.
> +
> +* All important information must be disclosed in the issue description,
> +  minimizing use of attachments to what is strictly needed. There is
> +  a strong preference for individual files to be attached directly.
> +  Avoid the use of archives (zip, tar, 7z, etc) to bundle files where
> +  practical.

Except this bullet point, everything LGTM. Here I'd enforce reporters to
attach a reproducer (in command line form, with image attached, pointing
to requiered public images to trigger the issue).

If not provided, personally as a maintainer I'd like -- or let scripts 
-- the ability to discard the *confidential* tag to issue with no
reproducer attached, as I don't want to waste time guessing / poking
around, possibly realizing the issue is not reachable.

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +
> +## Handling of disclosures

[...]


