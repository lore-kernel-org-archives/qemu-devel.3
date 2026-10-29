Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261BD606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MUi5nttr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IqI/wezk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUGD-00076L-P8; Thu, 29 Oct 2026 13:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMUGA-000714-4k
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:49:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMUG8-0004GL-1w
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:49:53 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGDbSw3689758
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ljUViM6l/JGsjMoOE8+0eh123NZIXr+WBJ8Mhxe4TN4=; b=MUi5nttr9S9D0sgA
 QfgdXIMpkLmqytEGwuKrg+efgWoXGlzYllSbO/ZwuBP3gBHUUakihEutksieSjMn
 QekkxWKLGCZXyTTcapA/yRfK9rhdhzMmazrvxFvbwmyLWvbcAkFkWFkEXADdNX3A
 guFnMgfj0youIyzbljIDFHep9yuJHDYbNseWHdf0Y/spyqhhrdKNQpriLZGKPtFC
 QAWa4eq96JKvfltD2hl5unOJ0ECyfq02EdmDTfUVzrJWL7i+0DZRkAwa7CLR22gJ
 hg+HwxJz/99F+XH0v4clF5+Ewvow31/Zj2ddpYIkDgjJmevubj+iWbP7rKeb5AYc
 weIXgA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hky5sbku2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 17:49:51 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so7737023eec.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 10:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793296190; x=1793900990; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ljUViM6l/JGsjMoOE8+0eh123NZIXr+WBJ8Mhxe4TN4=;
 b=IqI/wezki74RVvtmq2pfbnNNTY2NIe+UPcOcT6rYSMR2TR9ePjDDYATA9SL1smh23h
 sEEpUmY9fzOzkabOfIYczH7UBNklIS3hfxigBmmR1h8/mr3qTJETAmAeeFtGX+SSrLM5
 DRj2xZgn1WC1nJFK1cJdyciKjSdZcvY15apXfpRvuMqtIENkt4jNR47M7xfQyqxsT1Qm
 uCEI86RrJW4uPRYmn/FJ8onSoJuXFHr21ouJ/BhgOp51687QqGIXKzPClDTcAzFEvdY6
 bXUA5+LB5bOGnWvzq8LH9B+ewvkzpBlKZVO5ZW0iZk21PyhovQBRypTL8Y0KG9OnbVzq
 bjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793296190; x=1793900990;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ljUViM6l/JGsjMoOE8+0eh123NZIXr+WBJ8Mhxe4TN4=;
 b=kbxcmiVtcxSNn4vcV/hF6eiyQLLdMgGZT72qOAzhCeo5+VDcNka7Pz+ToQB1WEeflm
 DcgPT7kmqgJ9D9n98KWIjnhc1rRf8C8MMzz6wQ343d0t9S0F0tq84q2vgSeDOMlj52z7
 q0/ctFfeCxUr1TRfpvSTnrXAQZMGDI02sDwqJF24yvjB2fUBX18V9naiDT67akGDWAuK
 nKfN8NSfDGBgckifLe5Di4lfryp6JDn2XYJRsJV/KhwZRf7qBzR/RTPywg1HjtFgwhzm
 29ce9qnT/EEEBdTSSMlj97Z559+Gs8QwFR4hgCMJtfYOLuWMQxCHFVUOnve1xNMu9k1w
 Q+Nw==
X-Gm-Message-State: AFq9FYLHljeAP0RTN1ds+iFYjVk3Z07PIJsR/MocfLZlJ+9rhVLpr0Mv
 azcVEgNS34b8WsQKfyek4Zvwc8MypQwhEMJRKEi2CgqP+vTzq+of67b1W/ma6s22r5u/+8M6BEK
 VY4AdH/snWHVX+L8f8OKRRxC0xZKy1S8lkz5ngqXmjDxb7Z7C8i8gXrTFcA==
X-Gm-Gg: AYBFou3QcH8svBr3TaW0kuoJrOyg8DtJgUltyiCRC+0U81DpDhdorQIS+t7/varUcak
 qRVyl872Oof/Guq4NAFwfRVZX4U3iPUBJ9XTle+kTdCzJDVWDfFtJeT7MYQ82uCfW8i6E+YGTqW
 Yds3iawNEWGyrXuM2ZUHgvFZHf4iDF01qfRK+twr7xzb+RDfnPxZ45nKtuZsVzYKo87aMzHB9bu
 cid5pOoon2QwJzLgoNA6LqY6DzzYRag1185fTVR3pKobLJg8+Vy1IYK64vDC0tSmSNfbUy2NhZr
 /I8doRAAgvWjazPpU7O1jxcruFI2LnQFPVZOmBVouHq7CMNF3XH0TNgPPFVLqWcPLPgoQVQqYGX
 8XImSXGvkOItTPmEoFsiWwpja0kGCPmyDDADEQj3xlsyDJIKXR9GYbyj5OvfAD7RyWW1Od0AW9g
 BLZPHZshSmrtXyVGn/XMzUqvhmbyPqqz/Ap/sZJkmov20=
X-Received: by 2002:a05:693c:880e:10b0:369:779c:6e0b with SMTP id
 5a478bee46e88-36a4241bcc0mr145124eec.36.1793296189899; 
 Thu, 29 Oct 2026 10:49:49 -0700 (PDT)
X-Received: by 2002:a05:693c:880e:10b0:369:779c:6e0b with SMTP id
 5a478bee46e88-36a4241bcc0mr145082eec.36.1793296189297; 
 Thu, 29 Oct 2026 10:49:49 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429018casm117999eec.14.2026.10.29.10.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2026 10:49:48 -0700 (PDT)
Message-ID: <45679429-6a9b-4c5f-b173-7df41e5d5b69@oss.qualcomm.com>
Date: Thu, 29 Oct 2026 09:49:47 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] scripts/checkpatch: validate fixes against
 origin/master
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
 <20261029161310.2065290-2-alex.bennee@linaro.org>
 <c8bc6def-3c86-4fac-a84b-6664d40d5006@oss.qualcomm.com>
 <8733toa05f.fsf@draig.linaro.org>
 <e19ba1b4-60c6-47b4-b0b7-71e1be096a92@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e19ba1b4-60c6-47b4-b0b7-71e1be096a92@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3MCBTYWx0ZWRfX8/kGHYj652tm
 vR8Pw+l2tZvtPXCtmrFkB19Up+wDVNSLTd00wfRYg81LbP+zmdSwQ/LbbZCDimoxg8XHs0Q/Dn1
 qxICfcZLS1LbS+BVxujTHom4bdzkJtg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3MCBTYWx0ZWRfX9JmSJUyYirCd
 4E/07QRapxFcOnVGnHNxJuErv6VkHap8sa/2MHcBiURNa1YmzPxWvzEf6JxaEChiFtqBRa9ZZJk
 WsAgHXqXFQlMzz8cRIKqUNnGdcwJIjRNnAWo90EAamqN8CIgPn2UHQSbOTyfo6Ghpp7bm5YavVD
 yyWme3VjNh/ANp1bvqzaTOBw3UDzbLMTT7FMasQ+xsNBoBY4SpGdLSe3cbK06N8l8y21uA54qpm
 MNHnodZaU/axAz7hFBEl+ahTeGp2jpKbD4uSeqtDmiBiE1Mn4lVkkpP1rrp/PyX0wEOS6CG4Juw
 eb7wLuGqmk3GYT5FyH8B+S2iSaRxhOhgNnlws3yLc87fWUA1KFL8ddj2M9fSGcSuQgQi+zhqeYE
 Ci9L3uFvulNu4U2yrVXOOzvjk/BrEQ==
X-Proofpoint-ORIG-GUID: i3xo5gUDZbYn9DKU4sb66evSI6AorBcr
X-Authority-Analysis: v=2.4 cv=f/vdl+yM c=1 sm=1 tr=0 ts=6ae3873f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=811gYiKDY_HAMk8odT0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: i3xo5gUDZbYn9DKU4sb66evSI6AorBcr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290070
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/29/2026 9:44 AM, Pierrick Bouvier wrote:
> On 10/29/2026 9:26 AM, Alex Bennée wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>
>>> On 10/29/2026 8:13 AM, Alex Bennée wrote:
>>>> The current check for a referenced fix commit relies on the developer
>>>> keeping their master branch up to date which is not always grunted. If
>>>> you create your branches directly from origin/master this will keep
>>>> failing.
>>>>
>>>> Given that origin/master should always be up to date (module the
>>>> developer eschewing convention) lets use that in the test instead.
>>>>
>>>> checkpatch complains about the line lengths but this seems to be
>>>> standard for the perl script so I didn't try and fix it.
>>>>
>>>
>>> Or... you can use something else as origin, with origin/master not being
>>> updated, and master as a tracking branch to upstream/master, and in this
>>> case, this patch doesn't work.
>>>
>>> Using master instead of origin/master has the advantage to not hardcode
>>> what your remotes should be.
>>
>> origin is the default when you clone a repo. We could get really complex
>> and query the tracking remote for the current branch. But if your deeply
>> forked then that obviates the test.
>>
> 
> I am aware that origin is the default remote.
> In my case, I always use "upstream" to reference the original project,
> and "origin" for my personal fork. As a result, origin/master does not
> always track upstream/master.
> 
> With git tracking branch, master can be setup to track whatever/master,
> and not origin/master.
> 
> I would be surprised if I'm the only dev with such a setup, it's fairly
> common for any fork based workflow, and why git has tracking branches.
> 
> This patch basically forces origin/master to be aligned with the
> upstream, and nowhere else we enforce that, even if commit message says
> the opposite.
> ```
> Given that origin/master should always be up to date (module the
> developer eschewing convention) lets use that in the test instead.
> ```
>

The current patch is fine, I would just prefer to see it uses tracked
remote branch for master, instead of hardcoding origin/master (see git
branch -vv).

>>>
>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>> ---
>>>>  scripts/checkpatch.pl | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>>>> index 82f62f60212..60e8b6bf7bc 100755
>>>> --- a/scripts/checkpatch.pl
>>>> +++ b/scripts/checkpatch.pl
>>>> @@ -1913,9 +1913,9 @@ sub process {
>>>>  				}
>>>>  				if (which("git") ne "" && -e "$gitroot") {
>>>>  					my $hash = defined($cid) ? $cid : $orig_commit;
>>>> -					`git merge-base --is-ancestor $hash master 2>/dev/null`;
>>>> +					`git merge-base --is-ancestor $hash origin/master 2>/dev/null`;
>>>>  					if ($? != 0) {
>>>> -						WARN("Fixes: commit $hash is not an ancestor of master\n" . $herecurr);
>>>> +						WARN("Fixes: commit $hash is not an ancestor of origin/master\n" . $herecurr);
>>>>  					}
>>>>  				}
>>>>  			}
>>
> 


