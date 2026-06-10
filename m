Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6E8CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXG1M-0000xx-VV; Wed, 10 Jun 2026 06:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXG1L-0000xa-3M
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:18:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXG1H-0005zK-RX
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781086727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOiPZlOgyFOtKBueytOMhO7mQZleLu0jjYMVPytF7Sw=;
 b=bYVRa5PzTgvHzhHgZy7wiB8p1vJ4EHWEAE7iWokY3jCT7klEPA8kg/fWXvEOdbj5KhqPJT
 fCjIsB60RwATykIZasoOGS+PDlVfJ5gmto0JG9PJQEI5NjciBMTEQbCqStxGJI1PpDryX6
 31Ibxx3pmfzF7FlZUBF6HqhJR2rWPu8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-h7VEUzSAPYqhJL_b7R1JTw-1; Wed, 10 Jun 2026 06:18:45 -0400
X-MC-Unique: h7VEUzSAPYqhJL_b7R1JTw-1
X-Mimecast-MFC-AGG-ID: h7VEUzSAPYqhJL_b7R1JTw_1781086724
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-460129ef947so3950645f8f.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 03:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781086724; x=1781691524; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SOiPZlOgyFOtKBueytOMhO7mQZleLu0jjYMVPytF7Sw=;
 b=ZBOhxbCvrxTsxlXuPVbw0oBGQZvvoPkD0oIXwxmYB5okqQm5YHTISGgj7aJYLryga/
 BO2nsJIfxnVcXg04DSEqLAUOVzm6Uebn2UjiZgE7kzQswdO6ptyVC6OTgdWk9jM/Fu4H
 XGZ29dVvj9gV+R7KxLVorm/MyWaeGuPN2z9rUetUBchzcaO1rY6YJvlXxHDaZaOt9p/N
 2dWeX09AZX/ak/PzfW2S1syC6NZL2EF90+ybetwPshOYnLEAyAOWh+KxgZ4VkET71OHB
 jzFlQpVEYTtocAq99mr+e7I4lB+g9/xdpheZkmZ11DTjlZcH3/lUdBXmqDCsakBfWcKb
 556w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781086724; x=1781691524;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SOiPZlOgyFOtKBueytOMhO7mQZleLu0jjYMVPytF7Sw=;
 b=tLDfEzs/ArNnrY0WJWY8Vk5NbQa74ml5HzvY+jqHGlyxPiL+7PBU/ekVDMXiKSJzMt
 lcssv1iRNSz7pSxRrtxrSRQ5tmv713TwCH9Vq9ZPZlP0G83wQYUqJaiM5YHWQ6XjwdXu
 Z7YoKS4rBwaL8tLlJUshRawgCo+WRhp4G3s1nPfteE947AycEK5+o08EkKy/FLatSWCf
 CX+JFcIHGFBeH1HwdloPpizYDonwPEWdLDlh1ap5YYBYITWdVX55WshF0PPdXYRC8sVG
 T0LXffWVSquyItc61soXDrCAxzgbULr5Gey7Et/BKrzFyFRGKDn0zF3lloNEgwS1w9kA
 Z+aw==
X-Gm-Message-State: AOJu0YyuZwhWwtpI1f0NFPj/VshkPhVnE0Nw5sqF+jbCSZTyQcH598Sx
 9KOHyIvgDRJrVuhlZl5g7UK4JfjGpGFlHEDiA7CgO9VFRJE4fwDN8Wb/mxvotOmIadEoxrRQzqY
 QYHh7vJLkHjWYWIMu6p66GCVWSca2w5EhCOz5S3z6/aCTgo9CSw5Ykb7I
X-Gm-Gg: Acq92OF/eIhdZeXpN1waUaumf9Y5prbfBdj8GUY2sIpi6+sjQ841lM+b/eT+szZkCtw
 cRs7kYXXfK6hJ7fG/i4giBWF6v3I9J7pfu1ACXyfiYMcfvYdcrmAL+ZnuD1NEn7bUPUf7wP1N+G
 j4ME6tVEsNnXHzSgnaiyf76UGPN5wGUOSHMqMVawqw/Krgf+MCl5fSJn97dBxu2KfUvwyl/nkvb
 Jvj5BJDDKWDqVKcNsvYZgeG8Umlq7KRo3/y+lt5p7OX7KBbu9mYtgKKATZlOe4D48/iRWQu0n1k
 4YDMj3iaiFIuHVMZtjhhVrIb/6duHxaCgyHQ43y3yk6zCcJNwTmi7KX0EogcOWAfwYI8usCmrLq
 4HHte1l56uo7uv3mDBn9KLsOLvwaAPaW4wyHV40CBfBEcmCdPONrjhw==
X-Received: by 2002:a5d:6151:0:b0:460:1f32:628d with SMTP id
 ffacd0b85a97d-460302e364cmr26932379f8f.11.1781086723979; 
 Wed, 10 Jun 2026 03:18:43 -0700 (PDT)
X-Received: by 2002:a5d:6151:0:b0:460:1f32:628d with SMTP id
 ffacd0b85a97d-460302e364cmr26932341f8f.11.1781086723373; 
 Wed, 10 Jun 2026 03:18:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35eae5sm71328652f8f.33.2026.06.10.03.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 03:18:42 -0700 (PDT)
Date: Wed, 10 Jun 2026 06:18:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web RFC 3/3] contribute: switch security process to gitlab
 confidential issues
Message-ID: <20260610061728-mutt-send-email-mst@kernel.org>
References: <20260604165048.457860-1-berrange@redhat.com>
 <20260604165048.457860-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604165048.457860-4-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 04, 2026 at 05:50:48PM +0100, Daniel P. Berrangé wrote:
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
>  contribute/report-a-bug.md     |   9 +-
>  contribute/security-process.md | 280 ++++++++++++++-------------------
>  2 files changed, 119 insertions(+), 170 deletions(-)
> 
> diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
> index fd3bc6b..b506f9f 100644
> --- a/contribute/report-a-bug.md
> +++ b/contribute/report-a-bug.md
> @@ -11,6 +11,11 @@ on GitLab, taking into account the following guidance.
>    requested pieces of information that are relevant to the
>    discovered bug.
>  
> +* Bugs which are suspected, or known, to have security implications
> +  **must** be marked as "*confidential*" prior to submitting the
> +  disclosure. Consult the [security process](../security-process)
> +  for further guidance on security issue handling.
> +

Do we want to do like linux does, and make AI found issues public,
on the assumption that bad guys can find them just as easily?



>  * Reproduce the problem with the latest upstream QEMU release.
>    Reports against older versions may not be acted upon with
>    with the same priority.
> @@ -37,10 +42,6 @@ on GitLab, taking into account the following guidance.
>    guidelines](../submit-a-patch/). QEMU does not use a merge
>    request workflow for contribution.
>  
> -* Do NOT report security issues (or other bugs, too) as "confidential"
> -  bugs in the bug tracker.  QEMU has a [security process](../security-process)
> -  for issues that should be reported in a non-public way instead.
> -
>  * If the problem is believed to lie in the KVM kernel module,
>    following the [KVM wiki bug report](https://www.linux-kvm.org/page/Bugs)
>    guidance to submit an issue to the kernel bug tracker.
> diff --git a/contribute/security-process.md b/contribute/security-process.md
> index 5c708f5..a500b16 100644
> --- a/contribute/security-process.md
> +++ b/contribute/security-process.md
> @@ -3,169 +3,117 @@ title: Security Process
>  permalink: /contribute/security-process/
>  ---
>  
> -Please report any suspected security issue in QEMU to the security mailing
> -list at:
> -
> -* [\<qemu-security@nongnu.org\>](https://lists.nongnu.org/mailman/listinfo/qemu-security)
> -
> -Note that not all areas of QEMU are considered to provide a security
> -boundary. Consult the guidance at the end of this page for further
> -information on how QEMU classifies issues as security vulnerabilities
> -vs regular bugs.
> -
> -## How to report an issue:
> -
> -* Please include as many details as possible in the issue report.
> -  Ex:
> -    - QEMU version, upstream commit/tag
> -    - Host & Guest architecture x86/Arm/PPC, 32/64 bit etc.
> -    - Affected code area/snippets
> -    - Stack traces, crash details
> -    - Malicious inputs/reproducer steps etc.
> -    - Any configurations/settings required to trigger the issue.
> -
> -* Please share the QEMU command line used to invoke a guest VM.
> -
> -* Please specify whom to acknowledge for reporting this issue.
> -
> -* If any automated tools (AI/LLM based, traditional static
> -  analysis, or fuzzers) were used to discover the issue, the
> -  reporter is required to declare this at the start of the
> -  security report. Users of such tools are required to perform
> -  triage of their output. Findings and reproducer scenarios
> -  output by automated tools must be validated prior to submitting
> -  an issue to the QEMU security team.
> -
> -## How we respond:
> -
> -* Process of handling security issues comprises following steps:
> -
> -  0) **Acknowledge:**
> -    - A non-automated response email is sent to the reporter(s) to acknowledge
> -      the reception of the report. (*60 day's counter starts here*)
> -
> -  1) **Triage:**
> -    - Examine the issue details and confirm whether the issue is genuine
> -    - Validate if it can be misused for malicious purposes
> -    - Determine its worst case impact and severity
> -      [Low/Moderate/Important/Critical]
> -
> -  2) **Response:**
> -    - Negotiate embargo timeline (if required, depending on severity)
> -    - Request a [CVE](https://cveform.mitre.org/) and open an upstream
> -      [bug](https://www.qemu.org/contribute/report-a-bug/)
> -    - Create an upstream fix patch annotated with
> -        - CVE-ID
> -        - Link to an upstream bugzilla
> -        - Reported-by, Tested-by etc. tags
> -    - Once the patch is merged, close the upstream bug with a link to the
> -      commit
> -        - Fixed in: <commit hash/link>
> -
> -* Above security lists are operated by select analysts, maintainers and/or
> -  representatives from downstream communities.
> -
> -* List members follow a **responsible disclosure** policy. Any non-public
> -  information you share about security issues, is kept confidential within
> -  members of the QEMU security team and a minimal supporting staff in their
> -  affiliated companies. Such information will not be disclosed to third party
> -  organisations/individuals without prior permission from the reporter(s).
> -
> -* We aim to process security issues within maximum of **60 days**. That is not
> -  to say that issues will remain private for 60 days, nope. After the triaging
> -  step above
> -    - If severity of the issue is sufficiently low, an upstream public bug
> -      will be created immediately.
> -    - If severity of the issue requires co-ordinated disclosure at a future
> -      date, then the embargo process below is followed, and upstream bug will
> -      be opened at the end of the embargo period.
> -
> -  This will allow upstream contributors to create, test and track fix patch(es).
> -
> -### Publication embargo
> -
> -* If a security issue is reported that is not already public and its severity
> -  requires coordinated disclosure, then an embargo date will be set and
> -  communicated to the reporter(s).
> -
> -* Embargo periods will be negotiated by mutual agreement between reporter(s),
> -  members of the security list and other relevant parties to the problem.
> -  The preferred embargo period is upto [2
> -  weeks](https://oss-security.openwall.org/wiki/mailing-lists/distros).
> -  However, longer embargoes may be negotiated if the severity of the issue
> -  requires it.
> -
> -* Members of the security list agree not to publicly disclose any details of
> -  an embargoed security issue until its embargo date expires.
> -
> -### CVE allocation
> -
> -Each security issue is assigned a [CVE](https://cveform.mitre.org/) number.
> -The CVE number is allocated by one of the vendor security engineers on the
> -security list.
> -
> -## When to contact the QEMU Security List
> -
> -You should contact the Security List if:
> -* You think there may be a security vulnerability in QEMU.
> -* You are unsure about how a known vulnerability affects QEMU.
> -* You can contact us in English. We are unable to respond in other languages.
> -
> -## When *not* to contact the QEMU Security List
> -* You have not yet performed human review of the output of an automated tool.
> -* You need assistance in a language other than English.
> -* You require technical assistance (for example, "how do I configure QEMU?").
> -* You need help upgrading QEMU due to security alerts.
> -* Your issue is not security related.
> -
> -## How impact and severity of a bug is decided
> -
> -**Security criterion:**
> -    -> [https://www.qemu.org/docs/master/system/security.html](https://www.qemu.org/docs/master/system/security.html)
> -
> -All security issues in QEMU are not equal. Based on the parts of the QEMU
> -sources wherein the bug is found, its impact and severity could vary.
> -
> -In particular, QEMU is used in many different scenarios; some of them assume
> -that the guest is trusted, some of them don't. General considerations to triage
> -QEMU issues and decide whether a configuration is security sensitive include:
> -
> -* Is there any feasible way for a malicious party to exploit this flaw and
> -  cause real damage? (e.g. from a guest or via downloadable images)
> -* Does the flaw require access to the management interface? Would the
> -  management interface be accessible in the scenario where the flaw could cause
> -  real damage?
> -* Is QEMU used in conjunction with a hypervisor (as opposed to TCG binary
> -  translation)?
> -* Is QEMU used to offer virtualised production services, as opposed to usage
> -  as a development platform?
> -
> -Whenever some or all of these questions have negative answers, what appears to
> -be a major security flaw might be considered of low severity because it could
> -only be exercised in use cases where QEMU and everything interacting with it is
> -trusted.
> -
> -For example, consider upstream commit [9201bb9 "sdhci.c: Limit the maximum
> -block size"](https://gitlab.com/qemu-project/qemu/-/commit/9201bb9), an of out of
> -bounds (OOB) memory access (ie. buffer overflow) issue that was found and fixed
> -in the SD Host Controller emulation (hw/sd/sdhci.c).
> -
> -On the surface, this bug appears to be a genuine security flaw, with potentially
> -severe implications. But digging further down, there are only two ways to use
> -SD Host Controller emulation, one is via 'sdhci-pci' interface and the other
> -is via 'generic-sdhci' interface.
> -
> -Of these two, the 'sdhci-pci' interface had actually been disabled by default
> -in the upstream QEMU releases (commit [1910913 "sdhci: Make device "sdhci-pci"
> -unavailable with -device"](https://gitlab.com/qemu-project/qemu/-/commit/1910913)
> -at the time the flaw was reported; therefore, guests could not possibly use
> -'sdhci-pci' for any purpose.
> -
> -The 'generic-sdhci' interface, instead, had only one user in 'Xilinx Zynq
> -Baseboard emulation' (hw/arm/xilinx_zynq.c). Xilinx Zynq is a programmable
> -systems on chip (SoC) device. While QEMU does emulate this device, in practice
> -it is used to facilitate cross-platform developmental efforts, i.e. QEMU is
> -used to write programs for the SoC device. In such developer environments, it
> -is generally assumed that the guest is trusted.
> -
> -And thus, this buffer overflow turned out to be a security non-issue.
> +## How to disclosure a potential issues
> +
> +**The QEMU project no longer accepts security issue disclosures via email.**
> +
> +New disclosures must follow the [report a bug](report-a-bug.html)
> +process to file a GitLab work item for each potential issue, ***marking
> +it as "*confidential*" prior to submission.***
> +
> +If unsure of the security implications of an issue, err on the side
> +of caution and mark it as "*confidential*" initially.
> +
> +## Handling of disclosures
> +
> +Disclosures made via "*confidential*" GitLab issues are visible to, and
> +may be handled by, any QEMU subsystem maintainer whom has a GitLab
> +account [associated with the Reporter role in the project](https://gitlab.com/qemu-project/qemu/-/project_members).
> +Triage may also be performed by one or more automated tools and/or
> +AI agents run by the project that have been granted access to the
> +issue tracker.
> +
> +The first task upon receiving a disclosure is to evaluate eligibility
> +to follow the security triage process.
> +
> +* Disclosures affecting code / features evaluated to fall under the
> +[non-virtualization use case](
> +https://www.qemu.org/docs/master/system/security.html#non-virtualization-use-case),
> +will generally not be eligible for handling as a security flaw.
> +Such disclosures should be immediately switched to the public
> +bug report process by removing the "*confidential*" marker.
> +
> +* Disclosures affecting code / features evaluated to fall under the
> +[virtualization use case](
> +https://www.qemu.org/docs/master/system/security.html#virtualization-use-case),
> +will be handled under a lightweight security triage process which
> +emphasizes getting a fix merged to the latest development branch
> +as quickly as possible.
> +
> +Any disclosure which gets switched to the public bug report process
> +will be fixed at the discretion of the maintainer, if and when time
> +allows.
> +
> +In all cases reporters are encouraged to develop and propose patches
> +for issues themselves at time of disclosure, to speed resolution.
> +
> +**NOTE:** The QEMU project policy is that all security disclosures received
> +using GitLab "*confidential*" issues **will eventually be made public**. Any
> +information that the reporter considers to be be sensitive / private **must**
> +be scrubbed before disclosure.
> +
> +## Triage process
> +
> + * A maintainer will evaluate the circumstances of the issue
> +   to determine if it can be misused for malicious purposes.
> +
> + * If there is no potential for meaningful exploit, the disclosure
> +   should be switched to the public bug report process by removing
> +   the "*confidential*" marker.
> +
> + * If confirmed as a security flaw, a maintainer will request
> +   add the **"cve::required"** GitLab label to the GitLab work item,
> +   which indicates the need for a CNA to allocate a CVE.
> +
> + * The maintainer(s) will develop and/or review patch(es)
> +   for the issue privately, optionally attaching work in
> +   progress fixes to the GitLab issues. All patches must
> +   include the issue URL in the commit message(s).
> +
> + * When a CVE is allocated, it will be recorded as a comment on
> +   the GitLab issue, and the **"cve::requested"** label replaced by
> +   the **"cve::assigned"** label.
> +
> + * The maintainer(s) will update the commit message(s) to include
> +   the assigned CVE. If multiple commits are required to fix an
> +   issue the CVE must be included in the final commit in the
> +   series, and may optionally be included in all prior commits.
> +
> + * When the maintainer(s) are satisfied that the patch(es) are
> +   suitable to propose for merge, they must be submitted to
> +   the qemu-devel mailing list, and follow the normal process
> +   for merge henceforth.
> +
> + * At the time the proposed patches are sent to qemu-devel, the
> +   maintainers should remove the "*confidential*" marker from the
> +   GitLab issue.
> +
> + * When the patch is merged into the current development
> +   branch the issue must be closed. This should usually happen
> +   automatically if the git commits referenced the GitLab issue
> +   URL in [the normal format](https://docs.gitlab.com/user/project/issues/managing_issues/#default-closing-pattern).
> +
> +The QEMU project currently co-ordinates with Red Hat for CVE
> +assignment, in its role as the [CNA of last resort for OSS projects](
> +https://www.cve.org/PartnerInformation/ListofPartners/partner/redhat).
> +
> +## Embargo policy
> +
> +The QEMU project policy is to limit the time that a disclosure has the
> +"*confidential*" marker applied strictly to the minimum required to develop
> +and publish a suitable patch and allocate a CVE.
> +
> +Given the widespread use of AI/LLM based agents for security auditing,
> +as well as ongoing use of traditional fuzzing and static analyis
> +tools, the QEMU maintainers consider that any disclosure originating
> +from automated tools is highly likely to be independently re-discovered,
> +potentially many times over in a very short timeframe.
> +
> +Thus the QEMU maintainers will generally reject requests for arbitrary
> +embargos unless high severity, extenuating circumstances can be
> +demonstrated.
> +
> +If a patch for a confirmed security issue cannot be developed by a
> +maintainer in a reasonable time, the maintainers may choose to make
> +a disclosure public without having a patch available. This approach
> +should only be taken for issues judged to have low severity.
> -- 
> 2.54.0


