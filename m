Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDB0CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 19:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc6m6-0005qy-2I; Tue, 23 Jun 2026 15:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wc6m4-0005qW-T8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 15:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wc6m1-0006DI-Je
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 15:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782242822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A4FaBy6m42v53WFgZJanvwdVsiSI3wxMrxGTSmB3YNI=;
 b=Y3rSHpB4KAaoX7QNoWWBTZqBnOJue9euSMmQ8lHkoW6DakfRDu/KOFS0gvaZc0HYLnJeUS
 xIdSGqHP8ri8SgocRX2ZXNk37U5OGx+zZRmO+JGghkyOoBLECBdKi+ohB+/EyR+pH+n9et
 ZeQC4KqktV2I/KQlmqAAGNm3iUuSJkA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-t7ktpkc2MV6jZmFepaQ-Lg-1; Tue, 23 Jun 2026 15:27:01 -0400
X-MC-Unique: t7ktpkc2MV6jZmFepaQ-Lg-1
X-Mimecast-MFC-AGG-ID: t7ktpkc2MV6jZmFepaQ-Lg_1782242820
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-46010bc0f1eso149532f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 12:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782242820; x=1782847620; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A4FaBy6m42v53WFgZJanvwdVsiSI3wxMrxGTSmB3YNI=;
 b=dlgnOaYUEaiweffT4l8pjseYtFOkfKSlDcIM5Jrw2qYkM5rIxvKj4bNI90zzh0LMu/
 NVFsPhlIyEvfpT1cqF0/XHcHfXSQumwZoAmShdFLuOOz9hd+GesIzDRSAj8+/YDVm+H1
 dfgCG3ylhH68LaAFqjc+Va4NzvzEuaCqoH+bDKqspe7gW5zrDCzviG44AdiypUXihTWe
 GrD+thLqdwrLZyWf7gdxP8UcdhkLHPmDAN0GJgJ+ImmhOi3uFbosvC64Ti2cvifhbGun
 r6q+OAoKVncB+9aGM8J2TNenR+d9PBDmWxq+aEpXXvPrZHHRsDDVMzhiQAJsgkyKWum+
 niQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782242820; x=1782847620;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A4FaBy6m42v53WFgZJanvwdVsiSI3wxMrxGTSmB3YNI=;
 b=QbmEOIBCzOXgDc8k5SrvQtNZ0uf8mpTHLur5UARUrqwSJ+7mBHn4VobWuJ2XYLfSdm
 5wo6MSrT60QkWC4xph6YB+g3EENajfsuvoTN2+eBmdCLCUkh4cX5IYHC1aZdK8+cnem1
 GmNkTVQMQGIGbxM0B+uhVpnPklXK+FHz6X6coFAmKcKiVYGQf3zbJFsWA0ZIx8roKjnC
 upn3qRGWBvzr8rNHnzbbQMZtcxq3Y1vGuXX8FckEzAvVSjbT1rfIzP63aHldkNKOKhnt
 DunVxevx/HyeSPn/VEBtxMzBSjS+MmADmntvIOEZCUMPg754bV9L0JUyMrI2Gg1vbKkx
 HIjQ==
X-Gm-Message-State: AOJu0Yw+n69zSq8kx9eX34w+hgQj2/57g+PfWEfO1fbwd0utfIO0ZYI5
 LOYVLbN4MnDos/nACP3+G6l8QwW5GP7tmHKOHizQq3T+Dku58QgKh0Md+dgJHXlCveeOz0KB9jH
 B/pOSMbdT9ijCaFaz6c85yxPRWzQxzLfWAczXL24k3W7hC/7y7X37GEWP
X-Gm-Gg: AfdE7cl3xPT9fYDudhA2Z1CsxKmA0Smrra1uLMTACz7a+y5+CYvzcBUUqHb1OTj3iOz
 uVkH9h1mE1pzcFyUwzQ+eOjvr05vuH5SUHCB6iYY7nRUdb/BrKK1/rdt85hVd1RlW1VLGs/MBgR
 3kGX6N49lo2AMXthK4l1f6UIFVeeVtrNVpA7rh9tRfFulaOoFy9/OpmtGQtTaAFxOylKYnGPyMF
 +n+7pQ+VjuoOujy0V0OCbaJemVpDAyC6E6gKfDnLyCEengxCq2Pxj4tsoLhGNuSiokPqahpRPnA
 P2781MMQ5UQjH0yLkZUZf/tkVj8CPntlsd6FY1D63hVsaQCY+9Q/IZPczsT4GeBXRvVEvHEl6/N
 ad0Wx7i3YmSM883K8RjeAbJLBEmLPQF3O
X-Received: by 2002:a5d:5886:0:b0:467:ea82:1f85 with SMTP id
 ffacd0b85a97d-467ea821f94mr19922923f8f.28.1782242819823; 
 Tue, 23 Jun 2026 12:26:59 -0700 (PDT)
X-Received: by 2002:a5d:5886:0:b0:467:ea82:1f85 with SMTP id
 ffacd0b85a97d-467ea821f94mr19922884f8f.28.1782242819251; 
 Tue, 23 Jun 2026 12:26:59 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4e9esm35702827f8f.1.2026.06.23.12.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 12:26:58 -0700 (PDT)
Date: Tue, 23 Jun 2026 15:26:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <20260623150758-mutt-send-email-mst@kernel.org>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260529094619.1034458-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 29, 2026 at 11:46:19AM +0200, Paolo Bonzini wrote:
> Until now QEMU's code provenance policy declined any contribution
> believed to include or derive from AI-generated content.  A blanket ban
> was easy to maintain while LLM output was rarely usable on its own, but
> as the tools improved an absolute prohibition has become harder to
> justify.

In the hope to move this forward, here's an attempt to get all feedback
in one place. GPT-5.4. Unreliable of course but we have the contributors
here after all ). Guys, anyone feels any of his feedback got missed or
misstated?


## Alex Bennée

- Pointed out two text nits in the patch: a stray closing `**` and the wording `deterministic tool`, suggesting `deterministic tool or script`.
- Wanted an explicit rule that AI must not write commit messages, because writing the summary and rationale is part of demonstrating that the human author understands the change.
- Was okay with AI helping only with grammar and spelling correction of human-written commit messages.
- Later posted an experimental AI-generated rewrite that:
  - split the AI policy into a dedicated `ai-usage.rst`,
  - added explicit human-accountability language,
  - made `Signed-off-by` human-only,
  - discouraged prompt dumping in commit messages,
  - and banned AI-attribution tags other than `AI-used-for:`.
- Noted that the model was good at extracting text from the discussion but was not applying real judgment, so he normally prefers to review and reword AI-generated documentation hunks by hand.
- In the later security-report side discussion, said the interesting part is whether AI audit tooling finds useful issues compared to fuzzing/static analysis, not which model/vendor produced the report.

## BALATON Zoltan

- Said the terminology around `trailers` was confusing because elsewhere in the docs these are referred to as `tags`; that mismatch made the draft harder to follow.
- Otherwise thought the revised wording was clearer.
- Later objected to treating LLM output as presumptively public domain:
  - generated output may still contain copied or derived GPL code,
  - or code originating from incompatible or proprietary sources,
  - so "no human copyright holder" does not automatically make the result safe or public domain.
- Also noted that code added to QEMU without an explicit license is still governed by QEMU's licensing rules, so simplistic public-domain assumptions are risky.

## Peter Maydell

- Objected to allowing an individual maintainer to decide that larger AI-generated contributions are acceptable:
  - if the project concern is legal/provenance blast radius, that should be a project-wide rule,
  - not something that varies by maintainer preference.
- Was especially skeptical of allowing AI-generated documentation and comments:
  - code at least has compile/test guardrails,
  - prose docs have only human review,
  - and documentation/comments are supposed to reflect intended behavior, not auto-generated explanations.
- Drew a distinction between:
  - acceptable assistance such as grammar correction or translation of human-authored text,
  - versus asking AI to draft documentation from scratch, which he was much less happy with.
- In the later Coverity-style discussion, said issue identifiers can occasionally be useful for refinding patches/commits, though not as part of an everyday workflow.

## Stefan Hajnoczi

- Flagged one sentence in the proposal as potentially suggesting that submitters no longer need to understand the code they send.
- Wanted the policy to stay firmly in the model where the human contributor still understands and is responsible for the submission.
- Suggested wording along the lines of "since the risk of bugs not discovered by the submitter increases".
- Suggested moving the AI policy into a separate document and referencing it from `AGENTS.md`, so coding agents operating in-tree are explicitly told to refuse tasks that violate the policy.

## Daniel P. Berrangé

- Objected to using "projects accepting AI-assisted content have not run into serious legal trouble so far" as reassuring evidence:
  - copyright risk is a slow-burn issue,
  - lack of lawsuits so far is not strong evidence that the legal risk is low.
- Said `small bug fixes` does not line up well with the separate concern about `core code`:
  - the real policy goal is closer to low originality / low copyrightability risk / easy reversibility,
  - not "bug fix" as a category.
- Strongly preferred putting the AI rules into a dedicated `ai-usage` document for easier linking and clarity.
- Wanted the policy to cover social expectations as well as legal/technical ones:
  - QEMU collaboration should remain human-to-human,
  - contributors should not feed review mail into an LLM and paste the answer back,
  - reviewers using AI should disclose that fact,
  - and contributor identities should still represent real humans even when pseudonymous.
- Said the policy's "spirit" needs to live in the policy text itself, not only in a commit message, because later readers of the policy will never see the commit message rationale.
- Wanted stronger and earlier wording that only a human may add `Signed-off-by`, and pointed to Linux kernel wording as a model.
- Wanted explicit human authorship of commit messages and cover letters where non-trivial explanation is required.
- Liked `AI-used-for:` because it gives reviewers useful information without advertising a vendor.
- Wanted `shape your patch` tightened to something like `shape the content of the submitted patch`, so background AI use is excluded more clearly.
- Wanted unconditional disclosure of AI use, because provenance matters even when the surviving AI-generated portion is small.
- Thought prompts generally should not be included:
  - if the information matters to reviewers, it belongs in the human-written commit message,
  - otherwise it just adds clutter.
- Thought `QEMU does not use Assisted-by / Co-authored-by / Generated-by` was too weak:
  - if those tags are unwanted, the policy should explicitly forbid them,
  - and possibly enforce that in `checkpatch.pl`.
- Said the general tag rules should also be documented earlier in the provenance docs, not only in the AI section.
- Was especially wary of prose documentation under `docs/`:
  - AI prose can become convincing-sounding slop,
  - review of prose is already expensive,
  - and non-expert contributors may not actually be able to fact-check the text.
- Proposed handling documentation more incrementally:
  - start with a tightly constrained initial docs policy,
  - then relax it later only if experience shows that broader allowances are worth it.
- Was more comfortable with inline API docs/comments than with prose documentation.
- Opposed leaving larger exceptions to individual maintainer discretion because that would create inconsistent standards across subsystems and confuse contributors.
- Repeatedly pushed back on the `20 lines` rule:
  - it is not measuring the right thing,
  - and if there are already larger low-risk categories like mechanical or boilerplate code, the rule is the wrong policy center.
- Raised licensing concerns around AI-generated new files and SPDX handling:
  - some guidance suggests whole-file AI output should not automatically get a license header unless human edits make it copyrightable,
  - but QEMU should still make clear that human edits to AI-generated code are assumed GPL-2.0-or-later unless explicitly stated otherwise.
- Also clarified that any "public domain" argument for LLM output only makes sense when the output is not credibly a derived work:
  - cloning QEMU into another language would likely still be a derived work,
  - and some non-trivial feature code that follows established QEMU design patterns could also plausibly still be GPL-derived.
- Rejected the idea that "mechanical" should be left to personal taste:
  - if reasonable people might disagree whether a change is mechanical,
  - the policy should assume it is not mechanical.
- Said that if mechanical changes or boilerplate are allowed, the policy should define them clearly enough that contributors can understand what is allowed without having to ask permission in advance.
- In the later security-report side discussion, argued against giving AI tools `Reported-by` credit:
  - the accountable party is the human reporter,
  - and the project should not provide free advertising to tool vendors.
- When Alex posted an AI-generated rewrite of the policy, said it had incorporated comments too indiscriminately, become more verbose, lost structure, and was drifting toward slop.

## Kevin Wolf

- Said `20 lines or less` is a poor proxy for what the project is actually trying to allow:
  - the real target is trivial or low-complexity code,
  - and it is easy to write 20 lines that are not trivial at all.
- Suggested line count could at most be an example, not the entire rule.
- Noted that "just say no to slop" is easy to say but not especially comfortable in practice for maintainers.
- Was skeptical that LLM workflows are meaningfully reproducible anyway.
- In the later security-report discussion, said AI-found issues feel analogous to Coverity:
  - they generally do not deserve a `Reported-by` trailer,
  - but mention in commit-message prose can make sense if useful.

## Michael S. Tsirkin

- Suggested explicitly allowing AI to correct grammar and spelling in text the contributor already wrote, as long as AI is not writing the text from scratch.
- Argued there are cases where a maintainer may reasonably judge generated code to be so QEMU-specific or so tightly coupled to the current tree that accidental copying risk is negligible.
- Repeatedly emphasized that AI is especially useful for helping non-native English speakers.
- Questioned how effective the `20 lines` rule would be if many small AI-assisted contributions simply accumulate over time.
- Later suggested that if mechanical changes are allowed, the policy should say `clearly mechanical` or `obviously mechanical` and include examples.
- Also suggested that for borderline `mechanical` changes, contributors should check with maintainers up front because what counts as mechanical is still a maintainer judgment.
- In the licensing discussion, argued that if something truly is public domain, a human can still submit it under GPL terms, and that the policy could explicitly say contributing it to QEMU implies appropriate GPL licensing.
- Floated declining whole new AI-generated files for now unless they are just reorganizations of existing code that already inherit SPDX/licensing context.
- Also suggested maintainers can warn and eventually ignore repeat slop submitters.
- In response to the later security-report question, said AI-assisted security scanning was already allowed under the current policy.

## Christian Borntraeger

- Asked how the policy should treat a human-submitted patch that is based on an AI-generated security report.
- Asked whether, if such reports are allowed, the project should add something like `Reported-by: Claude` or `Reported-by: ChatGPT`.


