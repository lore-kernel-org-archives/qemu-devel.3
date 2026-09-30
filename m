Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23925CA5FAC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBtq6-0007yr-2r; Wed, 30 Sep 2026 08:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBtpF-0007hu-F0
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 08:54:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBtp8-0007dW-Kb
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 08:54:16 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UB8T9o3286525
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 12:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hPu2D8wl0it59+zYcN08xQa07UHIMQmPxPaYWEEoHxc=; b=cbeA6wNH/ZAhn6pg
 pavjI6c8dfySd9x039ncjmKeh5fICf4jQ+D8nY3NqFSNscsmGPoR6ijEz/3JdOYZ
 NL0LMWAOBC/iYjk38N0AZyojK6Ze0STk/dHkgsGStzroHCevVY3e0PjamoeGzOhm
 iKtQEMr7VV/N0IVYUPzd1bbgJMQcG7O/BgkKHhVhDiWfVVdq9LjtUGbnXDXqzvbG
 54djf7WzyLch+9KjsOxHFxrt+AecTXwfFYgjPAK/XFpFxRFBuVYiN7wqQHFRlOiH
 rnx2UdHSJuoZvZ7HK5H2MmqiaazB6bQdZVBmgSMJ0jR4AAHfZBQ7YW2eb2vsCn1r
 huWO2A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rj2tvw3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 12:54:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93ae8e7e546so1048056385a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790772852; x=1791377652; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hPu2D8wl0it59+zYcN08xQa07UHIMQmPxPaYWEEoHxc=;
 b=JC7cDD+60qA57mEmU7v5Xx0CoGq5XK5gIM2r+Dxl5cd5+4JDBw4p+OzoRkqVvM/err
 izPHzk7Fnxmc/V3ycoP6cDcdpz5w3QqcI/t6MY4XD/YKscerCqJz0Bzs99JG9cNUeb0F
 f3QkYSXY9/2/bmCR8dLBE9ABXfBoEGNVcVdJO/hhzF3WiyGkie+EJCBNPGcdXeJIaUbX
 FRNDlC7lKCcE5UcolvUtskB/Iom3GiDwdwB33AlIe+AOBfsNTozODdYYc+0ydIM97Dw5
 B8EQEslNB0gFa7s3GBACDIKbrhoI214xhr+HIz3bfE9JzJ81Kt4nABjoXKFPNKhVmEdD
 MPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790772852; x=1791377652;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hPu2D8wl0it59+zYcN08xQa07UHIMQmPxPaYWEEoHxc=;
 b=IU2struT6Vb4JYq5m/m5147YfQuOIHbS7wxKjCCVSF5z9q1PlrTcERyt3SJPesCGSd
 7vdsv5pD4pYqiioJY+Z5yqv0QtX/TX0JcT3IdSWr4zTxGWAbBQ1H0n1tss2jlSOQxhSk
 HoCSr6HE2xtjbBWGs6HdWZqtfW2ND6t+TV8kzMgcKkmRV3RIsIbr1eY8OgCnD7+sqpRy
 NZmFYj14nCoKsKcF+uuZNOIDj7097HCfGbCFfgZFttvWBeYgEObMv4Rmp6XVvCPFyFc9
 /2RlRhy4xdf381V/cUv/N9pOKqPK2NHFQFKoiaxQriScWlGHe89ljlzz9smGjKQnFnZS
 RCMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBziuRaM/sfg88/OepLPpPL2NlBPOvmTWMEKfP5TvCLmDBzQFkpH+xdWZqrjuMHpzmlWwunZJ/TurEk2@nongnu.org
X-Gm-Message-State: AFuF++lNDLONsE405UIndGf9EqudcWWS63sFizTjX4iJQTBCSfRF4Hiz
 IbwsYWaMsH7UTy2CxJPCOdr7pB/jxYMmJlnLVpdeStV/Zo/cT+Pt1h6F7rGmv1gQ/azDLMugB6j
 XgERdtckMePa7qZ6RX1KGuTJxG2UD0rk59XMyXd/zOyaCT4QoMtV6Fo/rqQ==
X-Gm-Gg: AYBFou1aoGQEbuKxTW14LVn2BLOgOHlAgne2ZrXrFi/AaPxGATAW30cg5SUcg3oFWD9
 yUv29ZckgqdYFl0L1LFIgmnyZOID9RcorMxPS1lidOWPEIH1TX9Ib5OlNHZT//D8i/jikqR78Cy
 d00CyZiskhO21LO202dfOQHHkJqpZ3hXwhhX3rqiIL4Q98RTzLczu15weW32WyqYdebUK31xa9G
 HkNdofTABCRHDBBbD8ouq5AgO8fo0V2tGTICUmvU21uGP7azurYJa6jgniQAEvokASSYe3W9+xv
 fO6nJspVFOp5RcRECEvTocr8CvL+bj80A7+AhjkkbIUpYN+CsY966YWZOfF4wrIAIBKyAU+j6cb
 3rCixJtWwo6jxxDhIV4XF/xDoncbVPyLX1Q==
X-Received: by 2002:a05:620a:6602:b0:939:31b5:4e08 with SMTP id
 af79cd13be357-93ca9330afemr194167785a.0.1790772851589; 
 Wed, 30 Sep 2026 05:54:11 -0700 (PDT)
X-Received: by 2002:a05:620a:6602:b0:939:31b5:4e08 with SMTP id
 af79cd13be357-93ca9330afemr194159685a.0.1790772850805; 
 Wed, 30 Sep 2026 05:54:10 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a017520f98sm48393085e9.8.2026.09.30.05.54.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 05:54:10 -0700 (PDT)
Message-ID: <05ace2dc-5e44-4f4a-8254-4f9459bdef1c@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 14:54:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Content-Language: en-US
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260930085433.830743-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: q6mAhV_d7X1eFV6O4QKDov_UH3Gjg6nH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA1MSBTYWx0ZWRfX4EKqWk+Hs4nO
 IeTvICOm8m1Fqo2Xg8k9J9VgA71AuoTTkbuMGZ8QrryfXW+JyVknyHN41Au4YRAa9iOIdWBJ29m
 6pIszRthaCXVqsg5BMd4EqAgRZNjY/PW7WK/DyZatsCAMPvG1rxxXRLIRwz6FkIHFTgxop7btNQ
 0qiSbYoOVyl6Ceu+a2AFkpIrNopXrRscIXKcZyDYyjL3YXOPDQ9ulZh4+yV3+3SvqNmAj7h1ExF
 L2AqHlmFW6Cc/e01HYv3HY/fqm0Cnjm+Nq495GYTYno/1AiatJR8kQoseGhtKVsbXAProgVEaMU
 TSA0J35xt+PcDTaN9H2y7sspwGpZpy1Z2B4zNe14g7rpg3GkscQvbEPsivAJj1pnYUT6HeiwT36
 dg9SInzLnZx4lQDUbBc+jdf5E/liBJkjWnxaPrZk+Jpi+VWzGHim8ahHE/C9XQzPM/dosqEwZX8
 /ghDlTSDTwcKE/t9/ug==
X-Proofpoint-GUID: q6mAhV_d7X1eFV6O4QKDov_UH3Gjg6nH
X-Authority-Analysis: v=2.4 cv=Ypya1IYX c=1 sm=1 tr=0 ts=6abd0674 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=JF9118EUAAAA:8
 a=7Qk2ozbKAAAA:8 a=PmyWr1nVuGXeHGO5vD0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22 a=xVlTc564ipvMDusKsbsT:22
 a=1lyxoWkJIXJV6VJUPhuM:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA1MSBTYWx0ZWRfX/6zcK3j90u7+
 arXhag3yParYP1KMVGeWHbJ0leaie5fr4k8yQlr9azqY18aYsmvS4IDmokUnpXxB3mA+mefHIos
 G5qyWORuh99B7mfIoGI0OuzMd9hXyfE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300051
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

Hi,

On 30/9/26 10:54, Paolo Bonzini wrote:
> Until now QEMU's code provenance policy declined any contribution
> believed to include or derive from AI-generated content.  A blanket ban
> was easy to maintain while LLM output was rarely usable on its own, but
> as the tools improved an absolute prohibition has become harder to
> justify and enforce.
> 
> Even a simple code review task these days may result in the agent
> suggesting code changes, or producing a useful test case to verify the
> presence or absence of a bug.  A hardline interpretation of the policy
> makes it hard to use AI even for tasks that are explicitly allowed.
> 
> On top of this, several maintainers have pointed out that contributions
> that can be reasonably suspected to be AI-assisted or more have been
> posted and included.  Some of these contributions are actually of very
> high quality; it seems that the mailing list-based contribution process
> has mostly protected QEMU from low quality patches.  A prohibition on
> AI puts maintainers in a difficult position: on one hand the DCO process
> lets them rely on the submitter's certification of origin, on the other
> hand maintainers are supposed to know and implement the process policies.
> 
> Since the policy has been written, other projects have discussed and
> taken their stance on AI contributions.  These vary from full prohibition
> (though typically motivated by social reasons rather than legal, e.g.
> for Zig) to limited use (e.g. GCC, allowing small contributions and
> tests to use AI), to cautious experimentation.
> 
> This proposed policy seeks to implement the cautious experimentation
> approach, inspired mostly by the Rust project's policy and by Software
> Freedom Conservancy's own recommendations on LLMs and generative AI.
> 
> Relying on Conservancy's legal guidance allows us to focus on the
> interaction between contributors and maintainers.  Conservancy in
> particular provides this point to alleviate the concern that motivated
> the policy, about whether the submitter has the legal right to contribute
> the code and about unintentional reproduction of copyrighted code:
> 
>     "Copyleft Everything" remains the best viable and safest approach
>     Certainly those who want to release FOSS under non-copyleft licenses
>     have more to worry about when using these tools.
> 
> While we shouldn't treat copyleft as a silver bullet, it is effective
> as part of a defense in depth strategy that includes, for example,
> "de minimis" thresholds and `AGENTS.md` instructions that encourage user
> participation in the design.
> 
> Therefore, the revised policy considers QEMU's copyleft to be a viable
> approach to any unanswered legal questions about AI-generated
> contributions and their copyright status.  This lets the policy
> focus on the topic of what AI-assisted contributions require of
> maintainers.
> 
> In that respect, the Rust project's policy combines two unusual ideas.
> One is to hold them to a higher standard, in the spirit of using AI to
> work "better, not faster"; the other is to require "pre-arrangement" for
> "changes that are originally created by an LLM".  AI lowers the cost of
> producing a patch but does nothing to lower the cost of understanding
> and reviewing one; if anything it raises it, since a reviewer can
> no longer assume that the submitter has reasoned through every line.
> Pre-arrangement is an attempt to balance the shift of effort from the
> developer to the maintainer, and the QEMU policy includes the same
> provision.
> 
> Going full circle to the reason why we might need to review the
> policy, there is the question of how to make sure policy is applied.
> QEMU maintainers have already experimented with using AGENTS.md files;
> subsequent patches will also try to embody the "work better, not faster"
> mantra into an AGENTS.md file.  Nevertheless, some explicit prohibitions
> should be included in the policy, and they are indeed.  The list is short
> and based on the Rust policy and the GStreamer AGENTS.md file.
> 
> Revise the policy according to the above considerations, and introduce the
> "AI-used-for:" trailer as a record of where AI was used.  The standard is
> slightly different from the more usual "Assisted-by"; the intention is for
> the metadata to provide more information for reviewers to judge the result,
> and to scope areas for which Signed-off-by cannot guarantee full control
> of provenance.
> 
> In any case, use of AI does not relax any other contribution requirement:
> authors still need to comply with the DCO (declaring that they have
> corporate authorization to contribute, for example) and take technical
> responsibility for their work.
> 
> [Commit message largely based on discussions with Daniel Berrangé,
>   Alistair Francis, Peter Maydell, Kevin Wolf and others. - Paolo]
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: BALATON Zoltan <balaton@eik.bme.hu>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Warner Losh <imp@bsdimp.com>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Link: https://lore.kernel.org/qemu-devel/20260524083329-mutt-send-email-mst@kernel.org/T/
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   docs/devel/code-provenance.rst |  71 +----------
>   docs/devel/index-process.rst   |   1 +
>   docs/devel/llm-usage.rst       | 213 +++++++++++++++++++++++++++++++++
>   AGENTS.md                      |  42 +++++--
>   scripts/checkpatch.pl          |   5 +-
>   5 files changed, 252 insertions(+), 80 deletions(-)
>   create mode 100644 docs/devel/llm-usage.rst


> +.. _ai-used-for:
> +
> +Commit messages for AI-assisted changes
> +'''''''''''''''''''''''''''''''''''''''
> +
> +In order to disclose your usage of AI/LLM tools, add an ``AI-used-for:``
> +line before the :ref:`Signed-off-by <code-provenance>` line.  The trailer
> +is both a reminder of your DCO obligations and a guide to reviewers.  The
> +text is one or more of ``code``, ``tests``, ``docs``, ``research``, possibly
> +followed by an explanation in parentheses:
> +
> +To be able to certify the provenance of AI/LLM-generated code that you submit
> +to QEMU, you must follow the policies outlined in this document and in
> +QEMU's ``AGENTS.md``.  **By using 'AI-used-for', a contributor both
> +identifies areas of the patch that involved use of AI/LLM, and also
> +attests that their usage of AI/LLMs was in compliance with the policies
> +outlined in this document.**
> +
> +.. code-block:: none
> +
> +     AI-used-for: tests, docs
> +     AI-used-for: code
> +     AI-used-for: code (refactoring)
> +     AI-used-for: code (prototype)
> +     AI-used-for: research
> +
> +``AI-used-for`` should not be included for "background" usage such as
> +autocomplete or obtaining a pre-review of the patch.
> +
> +Do not include your prompts or summarize the conversation in the commit
> +message or cover letter.  Extract any information that is relevant to the
> +reviewer and include it in commit messages, cover letters or code comments.
> +
> +QEMU does *not* use ``Assisted-by``, ``Co-authored-by`` or ``Generated-by``
> +trailers to indicate AI usage.  In particular, do not specify the exact
> +AI model or tool used to create the commit.
> +
> +Deterministic tooling (sed, coccinelle, formatters) is out of scope for
> +the trailer, but should be mentioned in the commit message.

I noticed a discrepancy in a method docstring and a particular use case.
Since the method is used distinctly in various configurations (KVM, TCG,
RISCV, ARM) I asked a LLM "using the semcode tools only and deliberately
ignoring the method documentation, look at all the call tree and how the
passed arguments are used and explain what is expected of this method
to a junior engineer" then once I understood out what was wrong I could
update the docstring in the header. No code / comment generated by the
LLM ends in the commit / repository. IIUC this use case is compatible
with the new policy. What trailer should I use?

   AI-used-for: research
   AI-used-for: code (audit)
   AI-used-for: code audit (semcode)

'semcode' is a deterministic tool, so instead my commit should contains
'''
   When updating foo() contract in commit fe89fe89fe89 we forgot to
   update its documentation. Checking with the semcode tools, most
   callers pass @arg as a mask. Update the documentation.

   AI-used-for: code audit
'''

Would that be a good example?

Thanks,

Phil.



