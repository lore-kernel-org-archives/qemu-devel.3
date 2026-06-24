Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B444CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 19:01:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcSps-0007MC-0U; Wed, 24 Jun 2026 15:00:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wcSph-0007Ln-W2; Wed, 24 Jun 2026 15:00:22 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wcSpe-0003jf-PK; Wed, 24 Jun 2026 15:00:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 71B7D805EF;
 Wed, 24 Jun 2026 22:00:13 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c3c::1:22] (unknown
 [2a02:6bf:8080:c3c::1:22])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id C0e080BXAKo0-l8yvQP6V; Wed, 24 Jun 2026 22:00:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1782327612;
 bh=lAyJc5eFEmtzxDhbNKtJZAtPou6JlAhr9CFp5bGI8wg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=gIXanjCpmtoXZ9Z+fulhRrQvnL8AjtiHo4qf+xiOgVNuS++No6ka0UIOz1D5yQyHn
 gorxN8O30M9eh1usP5e0I1hFVuFKcnefun7K5Gsq1ydWHPKfddno0M+Ht7AAThvSnJ
 BW4aqKPW0MifdpRw465mwebudWQdUKAZW8AHbxYo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d535e60b-2cda-4d1d-b076-abb0652e113f@yandex-team.ru>
Date: Wed, 24 Jun 2026 22:00:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: support measure for commit
To: Jean-Louis Dupond <jean-louis@dupond.be>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 John Snow <jsnow@redhat.com>
References: <20260608110346.3231998-1-jean-louis@dupond.be>
 <20260608110346.3231998-3-jean-louis@dupond.be>
Content-Language: ru, en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260608110346.3231998-3-jean-louis@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

08.06.26 14:03, Jean-Louis Dupond пишет:
> Add a new option to qemu-img measure to specify the base node you want
> to merge the image into.
> This will open all the images between top and base, and calculate the
> size required for merging this layer into the base image.
> 
> Also modify the calculation so it takes into account the
> discard-no-unref setting of the base image.
> If discard-no-unref is enabled on the base, discarded blocks in the
> layers above the base will not free clusters in the base image, but will
> only mark them ZERO.
> 
> [1]: https://gitlab.com/qemu-project/qemu/-/issues/2369
> 
> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
> ---
>   block/qcow2.c                    | 90 ++++++++++++++++++++++++++++----
>   qemu-img-cmds.hx                 |  4 +-
>   qemu-img.c                       | 37 +++++++++++--
>   tests/qemu-iotests/178.out.qcow2 |  6 +--
>   tests/qemu-iotests/178.out.raw   |  6 +--
>   5 files changed, 121 insertions(+), 22 deletions(-)
> 
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 81fd299b4c..3e3578e831 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -5231,6 +5231,8 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>       bool has_backing_file;
>       bool has_luks;
>       bool extended_l2;
> +    BlockDriverState *base_bs = NULL;
> +    bool base_discard_no_unref = false;
>       size_t l2e_size;
>   
>       /* Parse image creation options */
> @@ -5311,6 +5313,21 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>               goto err;
>           }
>   
> +        base_bs = bdrv_find_base(in_bs);
> +        /*
> +         * bdrv_find_base() returns in_bs itself when the image has no backing
> +         * chain. Then this can stay NULL.
> +         */
> +        if (base_bs == in_bs) {
> +            base_bs = NULL;
> +        }
> +        if (base_bs && base_bs->drv &&
> +            !strcmp(base_bs->drv->format_name, "qcow2")) {
> +            BDRVQcow2State *base_s = base_bs->opaque;
> +
> +            base_discard_no_unref = base_s->discard_no_unref;
> +        }
> +
>           virtual_size = ROUND_UP(ssize, cluster_size);
>   
>           if (has_backing_file) {
> @@ -5326,8 +5343,10 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>   
>               for (offset = 0; offset < ssize; offset += pnum) {
>                   int ret;
> +                int retp = 0;
> +                bool count = false;
>   
> -                ret = bdrv_block_status_above(in_bs, NULL, offset,
> +                ret = bdrv_block_status_above(in_bs, base_bs, offset,
>                                                 ssize - offset, &pnum, NULL,
>                                                 NULL);
>                   if (ret < 0) {
> @@ -5336,15 +5355,68 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *opts, BlockDriverState *in_bs,
>                       goto err;
>                   }
>   
> -                if (ret & BDRV_BLOCK_ZERO) {
> +                if (ret & BDRV_BLOCK_ZERO && !base_bs &&
> +                    !base_discard_no_unref) {
>                       /* Skip zero regions (safe with no backing file) */
> -                } else if ((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
> -                           (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {
> -                    /* Extend pnum to end of cluster for next iteration */
> -                    pnum = ROUND_UP(offset + pnum, cluster_size) - offset;
> -
> -                    /* Count clusters we've seen */
> -                    required += offset % cluster_size + pnum;
> +                } else {
> +                    /*
> +                     * If there is a base image in the chain, query its
> +                     * allocation status for this region so we can decide
> +                     * whether the cluster survives a commit into the base.
> +                     */
> +                    if (base_bs) {
> +                        int64_t pnum_base = 0;
> +                        retp = bdrv_block_status_above(base_bs, NULL, offset,
> +                                            ssize - offset, &pnum_base, NULL,
> +                                            NULL);
> +                        if (retp < 0) {
> +                            error_setg_errno(&local_err, -retp,
> +                                    "Unable to get block status of the base");
> +                            goto err;
> +                        }
> +                        /*
> +                         * If the base contiguous block is smaller,
> +                         * use that pnum, so the next iteration starts with
> +                         * the smallest offset.
> +                         */
> +                        if (pnum_base > 0 && pnum_base < pnum) {
> +                            pnum = pnum_base;
> +                        }
> +                    }
> +
> +                    if ((ret & (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) ==
> +                        (BDRV_BLOCK_DATA | BDRV_BLOCK_ALLOCATED)) {
> +                        /* The overlay has its own data here; it is written. */
> +                        count = true;
> +                    } else if (base_discard_no_unref) {
> +                        /*
> +                         * With discard-no-unref enabled on the base, clusters
> +                         * allocated in the base keep their reference when the
> +                         * overlay is committed (discarded clusters are only
> +                         * marked zero), so count any cluster that has a valid
> +                         * offset in the base.
> +                         */
> +                        count = retp & BDRV_BLOCK_OFFSET_VALID;
> +                    } else {
> +                        /*
> +                         * Without discard-no-unref, committing the overlay
> +                         * frees the base clusters that the overlay discards
> +                         * (the overlay marks them zero). Every other cluster
> +                         * that is allocated in the base is retained, so count
> +                         * it unless the overlay zeroes it out.
> +                         */
> +                        count = (retp & BDRV_BLOCK_ALLOCATED) &&
> +                                !((ret & BDRV_BLOCK_ALLOCATED) &&
> +                                  (ret & BDRV_BLOCK_ZERO));
> +                    }
> +
> +                    if (count) {
> +                        /* Extend pnum to end of cluster for next iteration */
> +                        pnum = ROUND_UP(offset + pnum, cluster_size) - offset;
> +
> +                        /* Count clusters we've seen */
> +                        required += offset % cluster_size + pnum;
> +                    }
>                   }
>               }
>           }
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index 6bc8265cfb..f3f5c63773 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -78,9 +78,9 @@ SRST
>   ERST
>   
>   DEF("measure", img_measure,
> -"measure [--output=ofmt] [-O output_fmt] [-o options] [--size N | [--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] filename]")
> +"measure [--output=ofmt] [-O output_fmt] [-o options] [--size N | [--object objectdef] [--image-opts] [-f fmt] [-l snapshot_param] [-b base] filename]")
>   SRST
> -.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l SNAPSHOT_PARAM] FILENAME]
> +.. option:: measure [--output=OFMT] [-O OUTPUT_FMT] [-o OPTIONS] [--size N | [--object OBJECTDEF] [--image-opts] [-f FMT] [-l SNAPSHOT_PARAM] [-b BASE] FILENAME]
>   ERST
>   
>   DEF("snapshot", img_snapshot,
> diff --git a/qemu-img.c b/qemu-img.c
> index c42dd4e995..0aa53d7ef8 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -5653,6 +5653,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
>       BlockBackend *in_blk = NULL;
>       BlockDriver *drv;
>       const char *filename = NULL;
> +    const char *base_filename = NULL;
>       const char *fmt = NULL;
>       const char *out_fmt = "raw";
>       char *options = NULL;
> @@ -5676,6 +5677,7 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
>           {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
>           {"source-image-opts", no_argument, 0, OPTION_IMAGE_OPTS}, /* img_convert */
>           {"snapshot", required_argument, 0, 'l'},
> +        {"base", required_argument, 0, 'b'},
>           {"target-format", required_argument, 0, 'O'},
>           {"target-format-options", required_argument, 0, 'o'}, /* img_convert */
>           {"options", required_argument, 0, 'o'},
> @@ -5686,11 +5688,11 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
>           {0, 0, 0, 0}
>       };
>   
> -    while ((c = getopt_long(argc, argv, "hf:l:O:o:Us:",
> +    while ((c = getopt_long(argc, argv, "hf:l:b:O:o:Us:",
>                               long_options, NULL)) != -1) {
>           switch (c) {
>           case 'h':
> -            cmd_help(ccmd, "[-f FMT|--image-opts] [-l SNAPSHOT]\n"
> +            cmd_help(ccmd, "[-f FMT|--image-opts] [-l SNAPSHOT] [-b BASE]\n"
>   "       [-O TARGET_FMT] [-o TARGET_FMT_OPTS] [--output human|json]\n"
>   "       [--object OBJDEF] (--size SIZE | FILE)\n"
>   ,
> @@ -5701,6 +5703,8 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
>   "     instead of a file name (incompatible with --format)\n"
>   "  -l, --snapshot SNAPSHOT\n"
>   "     use this snapshot in FILE as source\n"
> +"  -b, --base BASE\n"
> +"     open FILE backing chain up to BASE (inclusive)\n"
>   "  -O, --target-format TARGET_FMT\n"
>   "     desired target/output image format (default: raw)\n"
>   "  -o TARGET_FMT_OPTS\n"
> @@ -5738,6 +5742,9 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
>                   snapshot_name = optarg;
>               }
>               break;
> +        case 'b':
> +            base_filename = optarg;
> +            break;
>           case 'O':
>               out_fmt = optarg;
>               break;
> @@ -5773,8 +5780,10 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
>           filename = argv[optind];
>       }
>   
> -    if (!filename && (image_opts || fmt || snapshot_name || sn_opts)) {
> -        error_report("--image-opts, -f, and -l require a filename argument.");
> +    if (!filename && (image_opts || fmt || snapshot_name || sn_opts ||
> +                      base_filename)) {
> +        error_report("--image-opts, -f, -l, and -b require a filename "
> +                     "argument.");
>           goto out;
>       }
>       if (filename && img_size != -1) {
> @@ -5787,12 +5796,30 @@ static int img_measure(const img_cmd_t *ccmd, int argc, char **argv)
>       }
>   
>       if (filename) {
> -        in_blk = img_open(image_opts, filename, fmt, 0,
> +        int src_flags = 0;
> +
> +        /*
> +         * When measuring with --base, avoid opening the full backing chain.
> +         * We selectively open only up to the requested base afterwards.
> +         */
> +        if (base_filename) {
> +            src_flags |= BDRV_O_NO_BACKING;
> +        }

so, for new option, we disable opening the whole backing chain...

> +
> +        in_blk = img_open(image_opts, filename, fmt, src_flags,
>                             false, false, force_share);
>           if (!in_blk) {
>               goto out;
>           }
>   

and then (partly) open it by hand,

Hm. Why do we need it? Because of new logic in qcow2_measure(), which rely
on backing chain being onlny partly opened, and we calculate the measure
for the opened part.

IMO, that's too complicated way. More native would be add a parameter
BlockDriverState *base_bs into bdrv_measure(), and make use of it, and
do not modify opening the chain at all.

> +        if (base_filename) {
> +            if (bdrv_open_backing_chain_until(blk_bs(in_blk), base_filename,
> +                                              &local_err) < 0) {
> +                error_report_err(local_err);
> +                goto out;
> +            }
> +        }
> +
>           if (sn_opts) {
>               bdrv_snapshot_load_tmp(blk_bs(in_blk),
>                       qemu_opt_get(sn_opts, SNAPSHOT_OPT_ID),
> diff --git a/tests/qemu-iotests/178.out.qcow2 b/tests/qemu-iotests/178.out.qcow2
> index 61506b519f..0984a74a50 100644
> --- a/tests/qemu-iotests/178.out.qcow2
> +++ b/tests/qemu-iotests/178.out.qcow2
> @@ -6,9 +6,9 @@ qemu-img: Either --size N or one filename must be specified.
>   qemu-img: --size N cannot be used together with a filename.
>   qemu-img: At most one filename argument is allowed.
>   qemu-img: Either --size N or one filename must be specified.
> -qemu-img: --image-opts, -f, and -l require a filename argument.
> -qemu-img: --image-opts, -f, and -l require a filename argument.
> -qemu-img: --image-opts, -f, and -l require a filename argument.
> +qemu-img: --image-opts, -f, -l, and -b require a filename argument.
> +qemu-img: --image-opts, -f, -l, and -b require a filename argument.
> +qemu-img: --image-opts, -f, -l, and -b require a filename argument.
>   qemu-img: Invalid option list: ,
>   qemu-img: Invalid parameter 'snapshot.foo'
>   qemu-img: Failed in parsing snapshot param 'snapshot.foo=bar'
> diff --git a/tests/qemu-iotests/178.out.raw b/tests/qemu-iotests/178.out.raw
> index 6d994a433a..81249e718b 100644
> --- a/tests/qemu-iotests/178.out.raw
> +++ b/tests/qemu-iotests/178.out.raw
> @@ -6,9 +6,9 @@ qemu-img: Either --size N or one filename must be specified.
>   qemu-img: --size N cannot be used together with a filename.
>   qemu-img: At most one filename argument is allowed.
>   qemu-img: Either --size N or one filename must be specified.
> -qemu-img: --image-opts, -f, and -l require a filename argument.
> -qemu-img: --image-opts, -f, and -l require a filename argument.
> -qemu-img: --image-opts, -f, and -l require a filename argument.
> +qemu-img: --image-opts, -f, -l, and -b require a filename argument.
> +qemu-img: --image-opts, -f, -l, and -b require a filename argument.
> +qemu-img: --image-opts, -f, -l, and -b require a filename argument.
>   qemu-img: Invalid option list: ,
>   qemu-img: Invalid parameter 'snapshot.foo'
>   qemu-img: Failed in parsing snapshot param 'snapshot.foo=bar'


-- 
Best regards,
Vladimir

