Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CF0105A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 13:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0g4X-0000ff-9I; Thu, 12 Mar 2026 09:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w0g4V-0000fX-Qr
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 09:27:27 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1w0g4S-0004ET-Ng
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 09:27:27 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 94A4880866;
 Thu, 12 Mar 2026 16:27:16 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b78::1:28] (unknown
 [2a02:6bf:8080:b78::1:28])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id FRHh1M0AASw0-OlrYZ9Kf; Thu, 12 Mar 2026 16:27:16 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1773322036;
 bh=SDYA7G5ns+SrZ3yRe2YPUL4V4vkVKRI7JDu9G2FDY2o=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=R1jSfPVqwcYP3S3q+Tb4cJRovoeltGFYTo2vXa25RMxAGkdyJJ+PdNbYJ9VdbbR7+
 2FVV4kFXzz9uc6nhMvBfKZbKJ35f37072EHXcTY53MSs3il/c7PYftq1puZqEWwBRb
 MJWAnA437torHTFlsXgapXUTYuGHKbAbag7L/R7s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c38f6c8d-1f10-427e-bf38-23cb282f5370@yandex-team.ru>
Date: Thu, 12 Mar 2026 16:27:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] vmstate: fix subsection load name check
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas
 <farosas@suse.de>, "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>
References: <20260312102626.891359-1-dtalexundeer@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260312102626.891359-1-dtalexundeer@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 12.03.26 13:26, Alexandr Moshkov wrote:
> When loading a subset, its name is checked for the parent prefix. The
> following bug may occur here:
> 
> Let's say there is a vmstate named "virtio-blk", it has a subsection
> named "virtio-blk/subsection", and it also has another vmstate named
> "virtio" in the fields.
> Then, during the migration, when trying to load this subsection for
> "virtio", the prefix condition will pass for "virtio-blk/subsection" and
> then the migration will break, because this vmstate does not have such a
> subsection.
> 
> In other words, if a field inside vmstate1 is set via vmstate2 with a
> name that is a prefix of the parent vmstate, then the field can "steal"
> a subsection belonging to the parent state.
> 
> Looks like it happens because migration stream for "virtio-blk" looks
> like this:
> 
>   [virtio-blk header] [virtio-blk fields] [virtio-blk subsections]
> 
> "virtio-blk" contains "virtio" field, so migration stream is:
> 
>   [virtio-blk header] [virtio header] [virtio fields] [virtio
> subsections] [virtio-blk subsections]
> 
> And when we load the subsections of the "virtio" device,
> vmstate_subsection_load() uses qemu_peek_byte() to try to figure out if
> this is his subsection. This is where we encounter an error.
> 
> Thus, the error occurs due to the fact that vmsd does not know how many
> subsections it has when loading (this does not appear anywhere in the
> migration stream), so it tries to load all the appropriate ones by
> names.
> 
> To fix this issue, we call vmstate_get_subsection() and, in case of
> fail, ignore it, pop the VMSD stack and will try to define this
> subsection for outer VMSD
> 
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> ---
>   migration/vmstate.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/migration/vmstate.c b/migration/vmstate.c
> index 4d28364f7b..8f3a69c26e 100644
> --- a/migration/vmstate.c
> +++ b/migration/vmstate.c
> @@ -639,9 +639,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,

more contex:

         if (strncmp(vmsd->name, idstr, strlen(vmsd->name)) != 0) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(prefix)");
             /* it doesn't have a valid subsection name */
             return 0;
         }

If go this way, I think this check for prefix ^^^ should be removed.


>           sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
>           if (sub_vmsd == NULL) {
>               trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
> -            error_setg(errp, "VM subsection '%s' in '%s' does not exist",
> -                       idstr, vmsd->name);
> -            return -ENOENT;
> +            return 0;
>           }
>           qemu_file_skip(f, 1); /* subsection */
>           qemu_file_skip(f, 1); /* len */


-- 
Best regards,
Vladimir

