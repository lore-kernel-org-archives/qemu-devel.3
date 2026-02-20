Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 988AEC56205
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 15:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtS36-0000Vu-Qr; Fri, 20 Feb 2026 10:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1vtS33-0000V7-7k
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 10:04:05 -0500
Received: from smtpout2.mo529.mail-out.ovh.net ([79.137.123.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1vtS2z-0002ee-TH
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 10:04:04 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.179])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4fHYRV2nhQz5w1G;
 Fri, 20 Feb 2026 15:03:50 +0000 (UTC)
Received: from kaod.org (37.59.142.100) by DAG13EX2.mxp5.local (172.16.2.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 20 Feb
 2026 16:03:49 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R0034a709c8d-400e-415d-92ad-322a0f5a26fd,
 AFFAC17DCC5F77700274900821995E29BD465B15) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Fri, 20 Feb 2026 16:03:48 +0100
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
CC: <qemu-devel@nongnu.org>, Oliver Chang <ochang@google.com>, "Alexander
 Bulekov" <alxndr@bu.edu>, Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [PATCH] hw/9pfs: fix missing EOPNOTSUPP on Twstat and Trenameat
 for fs synth driver
Message-ID: <20260220160348.29a93709@bahia>
In-Reply-To: <E1vrbaP-000Gqb-B3@kylie.crudebyte.com>
References: <E1vrbaP-000Gqb-B3@kylie.crudebyte.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG17EX1.mxp5.local (172.16.2.171) To DAG13EX2.mxp5.local
 (172.16.2.132)
X-Ovh-Tracer-GUID: 3ece6ec1-4e2b-4b95-9e6f-329de1ead8c1
X-Ovh-Tracer-Id: 8635089337469409699
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTE6cY6P+vkqFX3UPrqF3tjKWQcFNX1Z6NVbSEW60Xgni302YPyKLJAu8I0/G4o9sKwIl3n1QqZ56TpD19YH+uKDedfMFVol+7Z1y+swBUEqmVA9X+QtSJmOQZjej2nbzw09mekpmxuFzW8PMXJlyx6JqAgqYOHWaEEa2q96SizJXO4UFJtYOXOuDffiJ/M5ADFHc569OpYL486iAapmfFy2D9B07arUoDQDNTkdrMdA/YoSWljy0rmpMnjm8dzX4HF3b3xxL3tq+ipMcOEafGPo52D5mx7bu0P++pA6VyCJz27aTwJHherMBKKpWOHv6yqNka2spstqAv5Prj6msrPVjwbi2bJZg93lIHU5QSf3Tc/u3SPPWyAadx0qtk+yIf84xxjQ1xaj337M83Y/e22C3/Af7f7tF3r7SgYb0FFJ5EouJVe3CmnOyVOQbI3Ls6puSjMC8DrnXL9OFHCTd2yMDyS2w7U9VNdI6A9ifaayNcj9DCxWVvqV0b81YKn4sUnuSJnpR/ejvWusH2TWch48/kThmd1OsLQ5UW1gQUzw0usEWEpcY51cEjx5kCwldlMf1MwPXmmvEhhCK3ZO5H24ed3jDKbQ3DQErTD3x5nEEl+FBS3SIPUH9WqNOT2rhcWFaup6tCL892H6eN9Dv/7Hg5QPTjU+dJz6Wy9aO6mE5A
DKIM-Signature: a=rsa-sha256; bh=4gg6XLQWCDVRFm8+5cU17gJva7oWfvusRQpgLggnftU=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1771599830; v=1;
 b=EQpvDMVR7Ca+JyUKXuv3rlGQGL3TsR6SAtgSKq7MEIU5BeQ3kdLKb+RBOe5BSYmWV2bcGwe4
 2FLWdadTEwFcR1hLMxydOOJFnOM5oMMYPFNdK371shn67I7jblq0ifzqXyaVVLj34nIDhbFs/gA
 /OFJP9dMn9mYLCXIs5hrODKsEPdt9n1dcvxdC3cBPVLkEgqoiEsMRNnk/Yl3O1Alrb4RafbCh62
 2555gDQROkMpCftA/KDHe1BlkMOxWL1t+113BDlPRcPKXdISQrGc6YpgE5yBEmfxKSpfKWuere1
 wMb3g4zk0mr0o7kVKRWIrJqkZaY9cAVQevVrFLc3SqxzA==
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout2.mo529.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Sun, 15 Feb 2026 13:44:50 +0100
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> Renaming files/dirs is only supported by path-based fs drivers. EOPNOTSUPP
> should be returned on any renaming attempt for not path-based fs drivers.
> This was already the case for 9p "Trename" request type. However for 9p
> request types "Trenameat" and "Twstat" this was yet missing.
> 
> So fix this by checking in Twstat and Trenameat request handlers whether
> the fs driver in use is really path based, if not return EOPNOTSUPP and
> abort further handling of the request.
> 
> This fixes a crash with the 9p "synth" fs driver which is not path-based.
> 
> The crash happened because the synth driver stores and expects a raw
> V9fsSynthNode pointer instead of a C-string on V9fsPath.data. So the
> C-string delivered by 9p server to synth fs driver was incorrectly
> casted to a V9fsSynthNode pointer, eventually causing a segfault.
> 

Ouch... yet another path of the synth driver that was never actioned ;-)

> Reported-by: Oliver Chang <ochang@google.com>
> Fixes: https://issues.oss-fuzz.com/issues/477990727
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3298
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

A bit late but

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/9p.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 02366f43a8..e2713b9eee 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -3516,6 +3516,12 @@ static void coroutine_fn v9fs_renameat(void *opaque)
>          goto out_err;
>      }
>  
> +    /* if fs driver is not path based, return EOPNOTSUPP */
> +    if (!(s->ctx.export_flags & V9FS_PATHNAME_FSCONTEXT)) {
> +        err = -EOPNOTSUPP;
> +        goto out_err;
> +    }
> +
>      v9fs_path_write_lock(s);
>      err = v9fs_complete_renameat(pdu, olddirfid,
>                                   &old_name, newdirfid, &new_name);
> @@ -3606,6 +3612,11 @@ static void coroutine_fn v9fs_wstat(void *opaque)
>          }
>      }
>      if (v9stat.name.size != 0) {
> +        /* if fs driver is not path based, return EOPNOTSUPP */
> +        if (!(s->ctx.export_flags & V9FS_PATHNAME_FSCONTEXT)) {
> +            err = -EOPNOTSUPP;
> +            goto out;
> +        }
>          v9fs_path_write_lock(s);
>          err = v9fs_complete_rename(pdu, fidp, -1, &v9stat.name);
>          v9fs_path_unlock(s);



-- 
Greg

