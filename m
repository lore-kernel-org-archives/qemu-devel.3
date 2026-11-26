Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8E606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GuNLjkZ+;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HKSsgKNy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWZMP-00052Z-Mw; Thu, 26 Nov 2026 08:18:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWZMJ-0004yG-TD
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 08:17:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWZMH-0007ET-AD
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 08:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795699072;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzbiHvWi83sHXMdl5YBiX258AVKMaQj+Qqhk9Bn434A=;
 b=GuNLjkZ+YNJpLD/+3f1ZBhO0/KK/XKO0xhNLKeuLuktv98iNyU24dTRDDR3D16KBhEnrGC
 ZN1GrXEQkzMspk65m48M+uHWInpn0AhuTk6pz1gpIQyVV8oT7hIbMmrM2dYjMkUZItY8VF
 WVxQIHUXtfZ4+c3kiyTFRyqrtKPiI3M=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-Vcr9c4Q4ONud9hRzv37xIA-1; Thu, 26 Nov 2026 13:17:49 +0000
X-MC-Unique: Vcr9c4Q4ONud9hRzv37xIA-1
X-Mimecast-MFC-AGG-ID: Vcr9c4Q4ONud9hRzv37xIA_1795699069
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-55d3e7ba879so133241801cf.2
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 05:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795699069; x=1796303869; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BzbiHvWi83sHXMdl5YBiX258AVKMaQj+Qqhk9Bn434A=;
 b=HKSsgKNyBtL4Fsgh5iHJHvgHYc3HRuW0EXg3rTVZFBVUqkutlr7+D5Kl0WhTMgmArW
 koLtXxFORgIX8rK6Rsz1LDasRiPNEUOUcSiyvoyKGJbCb6XZ1lgGufVddud+6FxKbSdL
 Pwu5gGqfH1bsJnzixdczQJt2/jXBl71vF2qQQaj0+pmWZ61FUMb5N2OUnYDG9q6Qets3
 7fLBMj4pX0kL9xVatqzKpRbHNR/jyst/Q2HcAGFxv5652reFFl2Vaz/G97LTiJ52Hsty
 D3JsivkNnrqHwpskmyhWLs6mpE8cRUbNHoSlZ2MB1plIYR5AZHzdj9uwqXCpExMAeyZS
 DV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795699069; x=1796303869;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BzbiHvWi83sHXMdl5YBiX258AVKMaQj+Qqhk9Bn434A=;
 b=EBCdyVkG2qWgMd50n8/5Wo3873F0kSxZO6s6WWRk5NMU60lnLAb8V//iOYVibF8UMR
 wY1Uih42qkR/nYqq6OF7nUymaDMRcyK2TB1AsMC8IGUs/4ySzxr/yZ3uQtLUSkMwWPV0
 QpG9umRRW8YQg94MBNJ6W9QROq3OHSKkubtrjz2SMbhyx0nFsuJRd0lxLJuOGZLV+6iu
 s3E45LMSVGZET9E0Lx3jeZ5HgClnOYsdVItpDSri4IboK5LQ8afAdRRqZctYCw+3sXVv
 SdkqSfF8t2m84PAh5/Ct2Nm7guPECml1fae9GA4hfIa0twN+8z+Y72U7O5Y7JSExwn16
 DV6Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEXn6JGYZG1boyYWqgKlpddaV/Plq+BLcU0X/OcWXs3+BKfwQtkziXiGdFYsvYiEvFtiWnsjXB8mYhx@nongnu.org
X-Gm-Message-State: APuU4Z8qnFKJ/CeV7Q35PdpTdApiS3HgOARaKfv8kCLzfIZO63zOwTfA
 yTa6u8lR1T1kgukXVPiCSMawm4x1ihtfnlPxiH5X1Fuet6cFo+pbuLhbs4FftpRRj9q2FlHhWYB
 4pv8nbarFKkFDlOYjP/hQL57oKQHsStr778H7JP34P3HCMPoUslMbTF/D
X-Gm-Gg: AZFdTZeXe8Z4rEGSFHxfdrAieZKQhl0+8Vc7V1F1JDYQ+O390t291IfOzfgpjnc9SBH
 Q7hrJeCQyhTqV6b9NzG1yFkPP3Yu6GEOF+aM5HJSM0e9NfJmo3Gz2QiivQe6htCmsLB7ORvKnNo
 18G4wzIukqfrdTfr/+j1UxBQSB+1eXzsVamY2kOohe2BwBB02S/loCftfTmjm6akGkfHU9CEDYW
 5e2xmDWqSAUr/QvOSCLDWOrSpOR3gKUYdchiPfa0beUbMwdL0yi+4N3Wm2/No7/6dfhpjysvD8W
 rb5ihUeCCWyKid0GU0+eiQhY+T1BCkGOU9ONzydowLRizZv4z+430hE5pNOKVk3LitA+GMXtLWD
 G7KphqKKa4au7uMXBR722h8IOVb6Bzv2cOqImAzpodeya
X-Received: by 2002:ac8:5d04:0:b0:536:d47:257 with SMTP id
 d75a77b69052e-55d76a51101mr381503971cf.51.1795699069226; 
 Thu, 26 Nov 2026 05:17:49 -0800 (PST)
X-Received: by 2002:ac8:5d04:0:b0:536:d47:257 with SMTP id
 d75a77b69052e-55d76a51101mr381503391cf.51.1795699068670; 
 Thu, 26 Nov 2026 05:17:48 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349d14d1sm190481376d6.18.2026.11.26.05.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 05:17:48 -0800 (PST)
Date: Thu, 26 Nov 2026 08:17:46 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 philmd@oss.qualcomm.com, peter.maydell@linaro.org,
 berrange@redhat.com, eblake@redhat.com, alex.bennee@linaro.org
Subject: Re: [PATCH 1/3] docs/devel: relax policy on AI-generated contributions
Message-ID: <awgxegpODDyRxN2r@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261124164217.1768040-1-pbonzini@redhat.com>
 <20261124164217.1768040-2-pbonzini@redhat.com>
 <awX8HEfLfE2x4hu7@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87tsl3yeln.fsf@pond.sub.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tsl3yeln.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 01:14:12PM +0100, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Nov 24, 2026 at 05:42:15PM +0100, Paolo Bonzini wrote:
> >> +The QEMU community is a collaboration between humans, not AI agent
> >> +façades. The following items MUST be written by humans:
> >> +
> >> +- cover letters and commit messages
> >> +
> >> +- responses to reviewer comments
> >> +
> >> +- issue descriptions or comments
> >
> > [Just a pure comment, so not a request to change anything at v6 to block the
> >  pull at all]
> >
> > I think this is the part I raised the pure question in the upstream call
> > today, on that we won't really be able to identify what is written by AI,
> > and what is written by human.
> >
> > If we can't identify that in a realiable way, IMHO the policy here will be
> > hard to carry out.
> 
> Yes, but that doesn't necessarily make it not useful.
> 
> We have many laws on the books that can be broken, with and without
> intent, in ways that are notoriously hard to detect.  Tax fraud, for
> instance.  We keep these laws anyway.  They serve as a clear statement
> of what conduct we expect and demand.  We make some effort to catch
> violations[*], but accept that we cannot catch them all.
> 
> Could this policy be useful in similar ways?  Not the punishment part
> (there is none).  But a clear statement of what conduct we expect and
> demand.  Something we can point to when we reject slop.

Yes, could be. I personally trust QEMU maintainers to at least not abuse
it, then let's assume it's less of a concern on courtesy or wrong
judgements.

The other side I didn't mention is, it'll just still block some very good
patch proposers, who work with AI, update based on AI's commit log, do N
rounds of review and tests before sending, then when sending it proactively
state the AI usage.  In that case to follow this rule we must reject it, or
forcing them to rewrite commit log, which is awkward.

Just to say, I never thought we shouldn't reject AI slop..  It's just that
I thought we can reject it even without this rule making good people's
lives harder: maintainers can always make the decision reject something,
right or wrong.. without any reference needed.

> 
> [*] At least in non-failing states.

-- 
Peter Xu


