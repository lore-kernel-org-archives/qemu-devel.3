Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90530EDF159
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 12:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqsFN-0005EX-Cl; Fri, 13 Feb 2026 07:26:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vqsFJ-0005E8-0J
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 07:26:05 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1vqsFH-0007yQ-5g
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 07:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=tpyY72F8yUzq0aKtZb+oo5/R8xdMgMelH4fHoPkLbVg=; b=QXCDsMwYQ1GnwnbX7mwgCRTQdk
 3NR8l/LHf2jIF6O4wiUUBd3uSnPi+BvOs9OpkfczkCSVvL3MHty3VF/MeXHCscdF5zTjc5nsgvxdG
 ygZRw/yNisoTa95kzCN+pVPwV/fz/D42nSH/41MBuPTXWKV0ioMETZTFPvHM42YLqUFvGerqSaA0E
 EPoGdoaLqLFZolN5xDBQ0aAfb/FPJayHnuFu9pEpwCXjA2j5lmVDBDqSfpdT4ThyY0QA7fgKGdNRi
 fbadXBgewv9mP7qwnuZHP/FeoQL14U0vlYW28sudHqO4VPi882HcvrJ7bOsCvXGAYbVjlOx9ENtSK
 ipzuP//2P43aJoNOurTTc3P99z6A/uVNGXPFM97Z0E71IesVs/v5PQBNnCXlXIZFlHAukLCUUVJ97
 Xe8h6zwLttG9x28UVrWMZAvwqoVjKne3kiXrk3Oq+51u9YXZXIxRB6WrTyG2wtd2GQSaTVZP54xiX
 g6oQctlUwX20kjZVE8A/2WZRtTXqr2/vnAvxZSUPgE/KGBSiDIoo8c1IitKkQttjPZdRdJYEigQ4E
 Ff//XoHvA2DIXQj1xYlRa8D1FsLJcelnXiaqByk+D02Z2bwLV+K+wGN6UFbK0wvHVLTKNKqHJ1plC
 ugC/NOWmdg+gOofa0DP8GtZFQYjXtUo5UACs7xFkY=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Oliver Chang <ochang@google.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Alexander Bulekov <alxndr@bu.edu>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Greg Kurz <groug@kaod.org>
Subject: A.I. generated patch (was: [PATCH] hw/9pfs: fix heap-buffer-overflow
 in v9fs_complete_rename)
Date: Fri, 13 Feb 2026 13:25:57 +0100
Message-ID: <3030453.e9J7NaK4W3@weasel>
In-Reply-To: <E1vqq09-000FBe-2m@kylie.crudebyte.com>
References: <E1vqq09-000FBe-2m@kylie.crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Friday, 13 February 2026 10:56:05 CET Christian Schoenebeck wrote:
> From: Oliver Chang <ochang@google.com>
> 
> When `v9fs_complete_rename` is called with `newdirfid == -1`, it attempts to
> derive the directory name from `fidp->path.data` using
> `g_path_get_dirname`. This logic assumes that `fidp->path.data` always
> contains a null-terminated string representing a pathname.
> 
> While this assumption holds for the 'local' backend, the 'synth' backend
> stores a `V9fsSynthNode *` pointer directly in the `V9fsPath.data` buffer.
> When using 'synth', `g_path_get_dirname` treats this pointer as a string,
> often resulting in a short string like ".".
> 
> The subsequent call to `v9fs_co_name_to_path` invokes `synth_name_to_path`,
> which expects `dir_path.data` to contain a `V9fsSynthNode *`. It attempts to
> read 8 bytes (on 64-bit) from the buffer. If `g_path_get_dirname` returned
> a short string, this results in a heap-buffer-overflow read.
> 
> Fix this by checking for the `V9FS_PATHNAME_FSCONTEXT` flag in the export
> flags. This flag indicates that the backend supports string-based pathnames.
> If it is not set (as in the 'synth' backend), return `-EOPNOTSUPP` to
> prevent invalid memory access.
> 
> Co-authored-by: CodeMender <codemender-patching@google.com>
> Fixes: https://issues.oss-fuzz.com/issues/477990727
> ---

Oliver, IIUIC your patch was auto generated by A.I. and AFAICS QEMU's current
policies forbid any A.I. generated contributions in general:

https://www.qemu.org/docs/master/devel/code-provenance.html#use-of-ai-generated-content

It is also missing a Signed-off-by: tag BTW.

Technically the patch should better be generalized anyway, at least by moving
the V9FS_PATHNAME_FSCONTEXT check to the beginning of the function, as
renaming is only possible with pathname-based fs drivers.

Peter, would that be sane enough or would such a v2 patch considered as
"derived from A.I content" as well?

/Christian

>  hw/9pfs/9p.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 6fbe604ce8..546e70f75c 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -3310,9 +3310,16 @@ static int coroutine_fn v9fs_complete_rename(V9fsPDU
> *pdu, V9fsFidState *fidp, goto out;
>          }
>      } else {
> -        char *dir_name = g_path_get_dirname(fidp->path.data);
> +        char *dir_name;
>          V9fsPath dir_path;
> 
> +        if (!(s->ctx.export_flags & V9FS_PATHNAME_FSCONTEXT)) {
> +            /* path renaming is only supported for path based fid */
> +            err = -EOPNOTSUPP;
> +            goto out;
> +        }
> +
> +        dir_name = g_path_get_dirname(fidp->path.data);
>          v9fs_path_init(&dir_path);
>          v9fs_path_sprintf(&dir_path, "%s", dir_name);
>          g_free(dir_name);





