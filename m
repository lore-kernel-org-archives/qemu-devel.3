Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DABACA5FAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBtsb-0000K5-PH; Wed, 30 Sep 2026 08:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBtsY-0000Jm-Oe
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 08:57:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBtsU-0008FP-O1
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 08:57:45 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UB7aKP319197
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 12:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ceTxb8NQ3ZVb4lu8KEDBxj8YJrABdiiWamWOOa/ojbw=; b=bL/cxr0jxLKTZ8xf
 Olq+mhj39dgw72dtxkhvjFppBK3y+GvdbZ89yUDxn1yJwonP6d5K772Uf6wrjtRM
 TPcSEch/hhTpRfl35Bb5JhKe/3yYbWsLG16le063n9+RJ00sOqbgr+YrRe54Fl51
 IMvki0TtWprUSJnK8/pYU2G/zlz2mQ/skrLSLBnC5+Sx7FE3gwSjIv0q0h7VrDwo
 l5BXBrMZo/i9r/tux8jOokzCThUq5efE90j+3WP6l+MiE5Qez6aX0qEY/XLyVBLI
 QGDKMp0uOKPvPaEfll7ttpe4NfJkLAy15ExKODQZofv5Yl5jS6Ynb68o3AVdbQLN
 l1bZcw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0mfabsan-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 12:57:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-939f3426a7cso1186008385a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790773059; x=1791377859; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ceTxb8NQ3ZVb4lu8KEDBxj8YJrABdiiWamWOOa/ojbw=;
 b=RczeQOJ88N3GH17Gx4xA1ddJ7fO8i26flOyCSbM7lYDcTL9d3aLTUymYLLMFDCwwmS
 thIa76FWWsdGtqZEnZDjb36DwRIlYorP+u487JvZrruaNy5yfysAHuy946/bjh5bXYC8
 ydzEeuQe2hdosklv/viyTC8B0Od1Uh4S2WtWx/RVpmaId979xcWh8hEkf6waZG4DQgyk
 WsViKlt/Ta23zsDTczelF8W86N7R9hjnEC1x1X11arGoLBrxBAS2ZuJSPPOIvhrQoT5G
 wzqgAIN4zWnNc9ILBZBfTXdD8jG0WPGyuL6+xYb5tY4uamk6sudX1PhtF19nJjspnlh7
 SeiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790773059; x=1791377859;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ceTxb8NQ3ZVb4lu8KEDBxj8YJrABdiiWamWOOa/ojbw=;
 b=0b1FVsG92JXYbBYYKtZNWXVw0LXwLVW8jd6pJDf9VMm1jrMTEDcztD21So2fDNwCc/
 aDBkDYWVtPL5gU+aNpsmSoIZBZ+dF5keT+4zV3c6bJf9np17lA6Fe7OkPzwlzDsVYRlw
 beP0Jd3HAdbvEgaUf08IVBi4iIVgPhn1Fb9OLnwFh52wkk3DOHyRBpY5wSOv7o3FRMol
 OlqvnlFBe5QshSEHQU4+EZD+4gZ8rG/rIeR1LoA1gtnFijltVM93nQ9DtjqEy+DTgyFR
 hXM71uTBLKFgRr0Loxoybpl/zbuXy3aVY4ng1UG8NDmQ8HoBrkEGnBKn8J4jfIbx/Jlr
 frrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgH/vxHz7Tv1p8Hrbd1sJVkztHnUGI1KTiJj58wc7LEzgbUwHTnnLMtzjNP1ByknUYgrF1y7JGfySv@nongnu.org
X-Gm-Message-State: AFuF++mBMeq7i9KJwANukh1NrwMnLGCMZml6LvT9kJ9xEMx7XnyZUglb
 h9yHiLnUMwEWl5DgP6uTjMO6kymdQuR5IVSw5061UJuizqdzOSHWYj1NO/9QKvLtQt3F1T82frN
 jog5gaidoTPcOOxQ5MkyNHFdmApT0XQeEJsFl07FcTKgueBLRpDUDG+g7Mg==
X-Gm-Gg: AYBFou1WdoYLxQpbLxG6CYIZ9l6lEmuGJuuWsQCmotMNlr5DWu+mZp+3r+gOgm//mwL
 w7LKk56O+xKqvuw3XtR3jbDJK9nezqAylVrKk5rETpH2pi+FNICVZ3UIia5KaEnKuozLlKXwQ+8
 kPDDkVkVvrOJtLIdYLKaeGFZStFPykTGxLgFAoq0tgsZqu+1IoAXpOWgh+iKbX7zyY2zIbBSjXd
 81VCgkCkg0srs/q5d9oQt7qNs7QZeWrNYEmhDGE5i6acLn+uMKBf6BgQZnMkRJ7lC+k9g+cSvOm
 W/OFzPlksM9lsvcHCLz/lV57K+lY7Z4fzQbRDJ1mJ7xF94CCfSGL/wCkwqAUuQ7DAIxoXoMEH7Q
 RNXuyTyjZ03lf1KQXlHEJEeDNBaRwnMjtHQ==
X-Received: by 2002:a05:620a:700e:b0:93c:89a0:bf82 with SMTP id
 af79cd13be357-93ca96f5016mr210138785a.43.1790773059367; 
 Wed, 30 Sep 2026 05:57:39 -0700 (PDT)
X-Received: by 2002:a05:620a:700e:b0:93c:89a0:bf82 with SMTP id
 af79cd13be357-93ca96f5016mr210131285a.43.1790773058649; 
 Wed, 30 Sep 2026 05:57:38 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01ca32a44sm10280545e9.0.2026.09.30.05.57.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 05:57:37 -0700 (PDT)
Message-ID: <6d40e12d-8fcd-43f1-84ca-035c9c503b13@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 14:57:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-2-pbonzini@redhat.com>
 <05ace2dc-5e44-4f4a-8254-4f9459bdef1c@oss.qualcomm.com>
In-Reply-To: <05ace2dc-5e44-4f4a-8254-4f9459bdef1c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1MSBTYWx0ZWRfX7iYZlxlzb0TK
 eChuH8q1iCPNBIRSo7Xumt8NM6ksSYqum+AqirrN3/5cF120EsfqOnfKMeuf0jIznS4IxmZIzcY
 k25GP61JoTlmd5/y3QKZ7m9tD4YJdZrOQ7H5C04bDH6SX9vA5RxlN41Wu3rFAjG0xfVTUidCEiS
 bg1er/dp1hM0hSZ/jTrA8uSQauxRQbFs2AMZQCkOL3PIWrJyM4njsAbRpvtVqzbUxUcgNANqk1S
 gVpHv7gsKWC4zRRyXOy7NI7dyZiNG5/iZLVOGxyYGYNWC3EPkjruWub9bBofKnxGfiKJo4WgRbx
 LEYGHgjQYLV14qPszQqikG1gB+7znMjGSzBbJcS6NQOtmrSRzPtsi5gWQfai2khTdY2F1EIS/JQ
 yglTwuWbLpFmwcc5OMCs+bphFsvbMewvdHJRMbMGsVk55BnMyphoZeRR2O8Yiv6uj0olB2TLezX
 nMz2jedSekbqH7YKa1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1MSBTYWx0ZWRfXyCqmmxl2x6m3
 eHbjt9L2bOKeJ1/KVGE95IcIllYrXQtSCEAxexzZoDt0hM5YTryutkBGS/OZ3tLo98lZNniF2Ld
 4lmFEV0Bajn19bhsRRBgvrhJD943uSE=
X-Authority-Analysis: v=2.4 cv=RZEFmFtv c=1 sm=1 tr=0 ts=6abd0744 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=JF9118EUAAAA:8
 a=7Qk2ozbKAAAA:8 a=4P1eh5azQ1tdP-pGYakA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22 a=xVlTc564ipvMDusKsbsT:22
 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-GUID: qk84xt0Qh6UlLKhDFdpbdisQkc2Z8-PM
X-Proofpoint-ORIG-GUID: qk84xt0Qh6UlLKhDFdpbdisQkc2Z8-PM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300051
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

On 30/9/26 14:54, Philippe Mathieu-DaudÃ© wrote:
> Hi,
> 
> On 30/9/26 10:54, Paolo Bonzini wrote:
>> Until now QEMU's code provenance policy declined any contribution
>> believed to include or derive from AI-generated content.  A blanket ban
>> was easy to maintain while LLM output was rarely usable on its own, but
>> as the tools improved an absolute prohibition has become harder to
>> justify and enforce.
>>
>> Even a simple code review task these days may result in the agent
>> suggesting code changes, or producing a useful test case to verify the
>> presence or absence of a bug.  A hardline interpretation of the policy
>> makes it hard to use AI even for tasks that are explicitly allowed.
>>
>> On top of this, several maintainers have pointed out that contributions
>> that can be reasonably suspected to be AI-assisted or more have been
>> posted and included.  Some of these contributions are actually of very
>> high quality; it seems that the mailing list-based contribution process
>> has mostly protected QEMU from low quality patches.  A prohibition on
>> AI puts maintainers in a difficult position: on one hand the DCO process
>> lets them rely on the submitter's certification of origin, on the other
>> hand maintainers are supposed to know and implement the process policies.
>>
>> Since the policy has been written, other projects have discussed and
>> taken their stance on AI contributions.  These vary from full prohibition
>> (though typically motivated by social reasons rather than legal, e.g.
>> for Zig) to limited use (e.g. GCC, allowing small contributions and
>> tests to use AI), to cautious experimentation.
>>
>> This proposed policy seeks to implement the cautious experimentation
>> approach, inspired mostly by the Rust project's policy and by Software
>> Freedom Conservancy's own recommendations on LLMs and generative AI.
>>
>> Relying on Conservancy's legal guidance allows us to focus on the
>> interaction between contributors and maintainers.  Conservancy in
>> particular provides this point to alleviate the concern that motivated
>> the policy, about whether the submitter has the legal right to contribute
>> the code and about unintentional reproduction of copyrighted code:
>>
>>     "Copyleft Everything" remains the best viable and safest approach
>>     Certainly those who want to release FOSS under non-copyleft licenses
>>     have more to worry about when using these tools.
>>
>> While we shouldn't treat copyleft as a silver bullet, it is effective
>> as part of a defense in depth strategy that includes, for example,
>> "de minimis" thresholds and `AGENTS.md` instructions that encourage user
>> participation in the design.
>>
>> Therefore, the revised policy considers QEMU's copyleft to be a viable
>> approach to any unanswered legal questions about AI-generated
>> contributions and their copyright status.  This lets the policy
>> focus on the topic of what AI-assisted contributions require of
>> maintainers.
>>
>> In that respect, the Rust project's policy combines two unusual ideas.
>> One is to hold them to a higher standard, in the spirit of using AI to
>> work "better, not faster"; the other is to require "pre-arrangement" for
>> "changes that are originally created by an LLM".  AI lowers the cost of
>> producing a patch but does nothing to lower the cost of understanding
>> and reviewing one; if anything it raises it, since a reviewer can
>> no longer assume that the submitter has reasoned through every line.
>> Pre-arrangement is an attempt to balance the shift of effort from the
>> developer to the maintainer, and the QEMU policy includes the same
>> provision.
>>
>> Going full circle to the reason why we might need to review the
>> policy, there is the question of how to make sure policy is applied.
>> QEMU maintainers have already experimented with using AGENTS.md files;
>> subsequent patches will also try to embody the "work better, not faster"
>> mantra into an AGENTS.md file.  Nevertheless, some explicit prohibitions
>> should be included in the policy, and they are indeed.  The list is short
>> and based on the Rust policy and the GStreamer AGENTS.md file.
>>
>> Revise the policy according to the above considerations, and introduce 
>> the
>> "AI-used-for:" trailer as a record of where AI was used.  The standard is
>> slightly different from the more usual "Assisted-by"; the intention is 
>> for
>> the metadata to provide more information for reviewers to judge the 
>> result,
>> and to scope areas for which Signed-off-by cannot guarantee full control
>> of provenance.
>>
>> In any case, use of AI does not relax any other contribution requirement:
>> authors still need to comply with the DCO (declaring that they have
>> corporate authorization to contribute, for example) and take technical
>> responsibility for their work.
>>
>> [Commit message largely based on discussions with Daniel Berrangé,
>>   Alistair Francis, Peter Maydell, Kevin Wolf and others. - Paolo]
>>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Alex Bennée <alex.bennee@linaro.org>
>> Cc: Alistair Francis <alistair.francis@wdc.com>
>> Cc: BALATON Zoltan <balaton@eik.bme.hu>
>> Cc: Daniel P. Berrangé <berrange@redhat.com>
>> Cc: Fabiano Rosas <farosas@suse.de>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Peter Maydell <peter.maydell@linaro.org>
>> Cc: Warner Losh <imp@bsdimp.com>
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Link: https://lore.kernel.org/qemu-devel/20260524083329-mutt-send- 
>> email-mst@kernel.org/T/
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   docs/devel/code-provenance.rst |  71 +----------
>>   docs/devel/index-process.rst   |   1 +
>>   docs/devel/llm-usage.rst       | 213 +++++++++++++++++++++++++++++++++
>>   AGENTS.md                      |  42 +++++--
>>   scripts/checkpatch.pl          |   5 +-
>>   5 files changed, 252 insertions(+), 80 deletions(-)
>>   create mode 100644 docs/devel/llm-usage.rst
> 
> 
>> +.. _ai-used-for:
>> +
>> +Commit messages for AI-assisted changes
>> +'''''''''''''''''''''''''''''''''''''''
>> +
>> +In order to disclose your usage of AI/LLM tools, add an ``AI-used-for:``
>> +line before the :ref:`Signed-off-by <code-provenance>` line.  The 
>> trailer
>> +is both a reminder of your DCO obligations and a guide to reviewers.  
>> The
>> +text is one or more of ``code``, ``tests``, ``docs``, ``research``, 
>> possibly
>> +followed by an explanation in parentheses:
>> +
>> +To be able to certify the provenance of AI/LLM-generated code that 
>> you submit
>> +to QEMU, you must follow the policies outlined in this document and in
>> +QEMU's ``AGENTS.md``.  **By using 'AI-used-for', a contributor both
>> +identifies areas of the patch that involved use of AI/LLM, and also
>> +attests that their usage of AI/LLMs was in compliance with the policies
>> +outlined in this document.**
>> +
>> +.. code-block:: none
>> +
>> +     AI-used-for: tests, docs
>> +     AI-used-for: code
>> +     AI-used-for: code (refactoring)
>> +     AI-used-for: code (prototype)
>> +     AI-used-for: research
>> +
>> +``AI-used-for`` should not be included for "background" usage such as
>> +autocomplete or obtaining a pre-review of the patch.
>> +
>> +Do not include your prompts or summarize the conversation in the commit
>> +message or cover letter.  Extract any information that is relevant to 
>> the
>> +reviewer and include it in commit messages, cover letters or code 
>> comments.
>> +
>> +QEMU does *not* use ``Assisted-by``, ``Co-authored-by`` or 
>> ``Generated-by``
>> +trailers to indicate AI usage.  In particular, do not specify the exact
>> +AI model or tool used to create the commit.
>> +
>> +Deterministic tooling (sed, coccinelle, formatters) is out of scope for
>> +the trailer, but should be mentioned in the commit message.
> 
> I noticed a discrepancy in a method docstring and a particular use case.
> Since the method is used distinctly in various configurations (KVM, TCG,
> RISCV, ARM) I asked a LLM "using the semcode tools only and deliberately
> ignoring the method documentation, look at all the call tree and how the
> passed arguments are used and explain what is expected of this method
> to a junior engineer" then once I understood out what was wrong I could
> update the docstring in the header. No code / comment generated by the
> LLM ends in the commit / repository. IIUC this use case is compatible
> with the new policy. What trailer should I use?
> 
>    AI-used-for: research
>    AI-used-for: code (audit)
>    AI-used-for: code audit (semcode)
> 
> 'semcode' is a deterministic tool,

Method called:

  - semcode.find_function
  - semcode.find_callers

  so instead my commit should contains
> '''
>    When updating foo() contract in commit fe89fe89fe89 we forgot to
>    update its documentation. Checking with the semcode tools, most
>    callers pass @arg as a mask. Update the documentation.
> 
>    AI-used-for: code audit
> '''
> 
> Would that be a good example?
> 
> Thanks,
> 
> Phil.
> 
> 
> 


