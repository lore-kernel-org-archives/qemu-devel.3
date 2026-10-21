Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AD0606A31F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NJONJoOf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJPOi-0006dz-4e; Wed, 21 Oct 2026 02:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xJPOg-0006dp-8i
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:01:58 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xJPOe-0001sl-Gr
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 02:01:58 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-33fb4680717so898465eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 23:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792562514; x=1793167314; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KiIO9GrntS/w8uePxgl3Vd9OTpSGa26BwRf0UkwInw8=;
 b=NJONJoOf7Uc6ccf+ZEH17GwR+inVUZrU5ruiPJ4/tPnCMsvDm5XMiSOP0ipNvGpogo
 bv35q19iTyR6cCnuujzkp/tfKP9vuuhJ9fEQTGtiLncOD1lB636bOZTvKbuS6MF5LvZO
 ciy/YkISMiQVznWwRgE/Jlgf1JOBcOAwlmrVNZnvySYUjOeJrLaX9bxQH0SK4VhCEG2o
 kY37DA4vEAxdCofmoIBbuuNqq0guHg8nYcMkebv7fXkVCYEtbtga0D5iRY69TngF++EO
 Id/NOFmPjQpuS193Z9TciKfwbmk+clsvJ9kDJEBDN5f4dvldsFmpIgrv4FIE7TjWhmlS
 hCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792562514; x=1793167314;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KiIO9GrntS/w8uePxgl3Vd9OTpSGa26BwRf0UkwInw8=;
 b=POi0poGcnNV3tPs6+xCwDFvcfpjp0UVP5dzsepn72mTx9ZPtKVgJaJDx+cuZ/HkE/9
 D8CCEADkYkiFcuoq9sYv0dR39RlFHnSG5uTwMleHJw/WStB7OUjz2wc7nNkXUlBHWDDh
 /8YpVfqdE/W5vs9sf49VhhUlstIYxncxE/JYfu6r4CEjOegSV2e3C+R+kB3HeQdAv0LG
 tTopCYA0gArSkLhuwB4reEbYOMTLNXXOEu4f2BBVpiHAa7Wiq1WIG52Nda2+WzAQG1di
 S7GCg5lfzdB23VyYFWeEzczeljfQZwaMo3UP/aznP6XZFhLrGA6+yBTsGPXu39rQE4zx
 S+EQ==
X-Gm-Message-State: AFq9FYKlMD+rFgkeEABYCBO8x0/cdFUNOGNwK3TRa7qemStHepraEs1a
 YKf7anfPmG0ujACgfGjxFBqjDxg1I13NbblAR3A/mil1vUjKQEeUjR4S
X-Gm-Gg: AYBFou2oljSzuu2NVPUKJJX4iuLuMXmhSyHGHOFympzJCfL1mMhED3LL2UOD6N3iVfH
 dDAm/gWAeaEW8FqMy5UZPOJtlBjfHVJFboUDi/ra9+fNhfIuLme7PsjJJNuUDkbs8RfcWEdyTi4
 P3s2vaI9ojj3aef+fAqd+mIY63hsnWi3OcJhnvWu3Mc8dlu9irmq+eheaDX8BjVz92eiJfZ47zg
 cbr8o0hgzTablfNsS7AaCFN/ZNWQXlRRDGOsVB/zMZdiv3ocEYXIXlBSnxKh8pF+6YqPl6pZEST
 blkCxcoPV6JIwDDfz8bCQVFSSd/UQIeZy6mNtYuSAtpPkq5nxFmKM31/LFniILfmP6MpsJon/n0
 nWwKbly4qawvKfJHKxK/ervgJInnggkRPobMRpE2u9AoYWseNbgq8wTIrHFlqoYJmJ6vR0q9YI1
 cv7dSP3rNaQ0FCic1aI2b7Oe2K8wJMuSrYYKN4itKm92GGyWaAsZNhyMNCV+ZxJMer4OyhBnBDF
 vcmAtUN9gvFyiC5DUIIv3+Yx00RrTDhnI+pZw+xM0OG8e0xztEt6ZHkr6LNHqAURGij96EfDKc0
 Df2P5OcIWvAF1sI=
X-Received: by 2002:a05:7300:8246:b0:351:7f5c:dbe1 with SMTP id
 5a478bee46e88-3674db50adamr1901081eec.28.1792562514245; 
 Tue, 20 Oct 2026 23:01:54 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3674198fb21sm3969227eec.23.2026.10.20.23.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 23:01:53 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/8] hw/ufs: Handle task management requests for
 fault-injected held requests
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>, 
 stanleyjhu@google.com
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>
In-Reply-To: <20261015060827.341298-3-stanleyjhu@google.com>
References: <20261015060827.341298-1-stanleyjhu@google.com>
 <20261015060827.341298-3-stanleyjhu@google.com>
Date: Wed, 21 Oct 2026 15:01:33 +0900
Message-Id: <179256249332.381710.14668490787591510124.b4-review@b4>
X-Mailer: b4 0.17-dev
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_PDS_OTHER_BAD_TLD=0.01 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,T_PDS_OTHER_BAD_TLD,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> Wire up Task Management Request (TMR) and MCQ submission queue cleanup
> handling for transfer requests held by x-fault-inject-tag according to
> x-fault-inject-mode:
> 
> - "abort-success": UFS_QUERY_TASK returns
>   UFS_UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED. UFS_ABORT_TASK cancels the
>   underlying SCSI request and marks the MCQ request in error state for
>   SQRTC.ICU cleanup (or clears the legacy UTRL slot), then returns
>   UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL.
> - "abort-failed": UFS_ABORT_TASK returns
>   UFS_UPIU_TASK_MANAGEMENT_FUNC_FAILED while keeping the request held.
> - "in-transition": UFS_QUERY_TASK and UFS_ABORT_TASK complete the held
>   transfer request with success and return
>   UFS_UPIU_TASK_MANAGEMENT_FUNC_COMPL.
> - "timeout": UFS_ABORT_TASK skips completion so the host driver hits
>   its TMR timeout path.
> 
> Also clear u->held_req and disarm active_fault_inject_tag when an MCQ
> submission queue containing the held request is cleaned up via
> ufs_mcq_sq_cleanup().
> 
> Signed-off-by: Stanley Jhu <stanleyjhu@google.com>
> ---
>  hw/ufs/ufs.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 89 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
> index e715182b6f..33940e39a8 100644
> --- a/hw/ufs/ufs.c
> +++ b/hw/ufs/ufs.c
> @@ -761,6 +761,87 @@ static void ufs_fault_inject_hce_reset(UfsHc *u)
>      }
>  }
>  
> +static void ufs_fault_inject_complete_held_req(UfsRequest *hreq)
> +{
> +    uint16_t data_seg_len = sizeof(hreq->rsp_upiu.sr.sense_data_len);
> +
> +    hreq->rsp_upiu.sr.sense_data_len = 0;
> +    hreq->rsp_upiu.sr.residual_transfer_count = 0;
> +    ufs_build_upiu_header(hreq, UFS_UPIU_TRANSACTION_RESPONSE, 0,
> +                          UFS_COMMAND_RESULT_SUCCESS, 0, data_seg_len);
> +    ufs_complete_req(hreq, UFS_REQUEST_SUCCESS);
> +}

Is it intentional that in-transition reports successful completion without
executing the SCSI command or transferring any data?

If this is intended for fault injection, could you briefly mention it in
the commit message or the mode description?

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

