Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EFDC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 22:26:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOkwK-0003wK-Kl; Mon, 09 Jun 2025 18:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOkwI-0003vu-OG
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 18:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOkwH-0006DN-6S
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 18:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749507954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U1b9zRLyEiJw1aGecTlL3Fo4KJbgeDuJGMYTzV0cT2M=;
 b=ORcQAvExJIEsmJTnqbPON4uW36lOa4BHgofrfSph1KL8LPBDaM7+IpsAKCk0MDQOofhH4V
 2yaHJhuArR4vH4KL2NN3ad4gZAyRMHC93/2CopdmdPPaaa1bcUz9pub86EXivp2CSJz7iD
 GTmYrWScA8tHHkvYSprDKLIyT7FObZE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-57-F3MNrUH6PQSSIi_5Ivc4Vg-1; Mon, 09 Jun 2025 18:25:53 -0400
X-MC-Unique: F3MNrUH6PQSSIi_5Ivc4Vg-1
X-Mimecast-MFC-AGG-ID: F3MNrUH6PQSSIi_5Ivc4Vg_1749507953
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4a587a96f0aso132811201cf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 15:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749507953; x=1750112753;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U1b9zRLyEiJw1aGecTlL3Fo4KJbgeDuJGMYTzV0cT2M=;
 b=rYLxE1F7nDuTkx7bO8PgBGgBWFYJtD+aS13pWTzfB8oInHw8iqTcDQpJRsC6O8jMEe
 s8FeGbzbDkzDqwqbCKz/u26WhtJCaKemvl92MkWTAtah5HnbNzmLJevUtau7amLKHvfz
 b2gkIMNN76+FshiaaIsPCsipHVENbf8XAjvjY9pc3ndBabUK9clF/MvxcXeEz+nHbYIV
 zdSVvp3mcs8gv3SjlNEXLmDbKfWmM71cWVgEsVoInWq3MBrJAWyP15VmN+h5ofI7r/kZ
 czVTF++6FUe4IVIwDAhRWz/A4oVWlS89lQ6crybJkA2dHBk7Vbm6Yyzth/VI3aRlopqc
 B8Ng==
X-Gm-Message-State: AOJu0Yy7hAwGV+el6jLJ+sLaNnwBM61tfB38N/w770HNI8Ei11BuGTH4
 t+egKawMGU+2jyeNu+O3Nntv6tFz1CiGT5vDns3IIvPEyXFcuUrL+9u4UbVF0ZSyl9XGT9/NrgK
 Ni/tg3E82Wy1EvfAUtJtbNCwZyTicrdXJ+1l/BAfyTlVUpt2mdZqdFGVUkk7rsN4Afh9TtBXGqW
 1x3Ecv9TOeGT3B95KE5dAOreQ+XupgdMTO+nEZFQ==
X-Gm-Gg: ASbGncuApfgHniIA8HxlDzDRuTiIFSrpGH8tETEwnBlQ/ruIDW1gJiOx3etjy2BvBje
 PNbpn9QU1xvdXJorlMLnxSyqmeDa/bYnzdcTKYK83eONRxsxMX5ToHYdbJwT8HzlwAliq4szzpb
 ZxArrzPQD/brsSNogU1rFMQrcl4K9tS0yOduQ9lpk48NlaOKnQphhg1/Mm5bJujwz/Axd9EDT1s
 ZD04C1d0fzGavbgc3vgzRUJKzNVK3CkZTqdbD9tcf9HIHLMGZVGeFDZhU8Pj8qYR+EGPFU7/zR1
 qJaTH1jwJbDbRw==
X-Received: by 2002:ad4:5ce1:0:b0:6e8:9394:cbbe with SMTP id
 6a1803df08f44-6fb08f857b3mr243649246d6.20.1749507952537; 
 Mon, 09 Jun 2025 15:25:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEM+3bxBPud7nSrmZz43bKhG+t1m8wJNnNSccfdnVkhj70C1hIuG7FsezdLt81k+Ye7n0rzgw==
X-Received: by 2002:ad4:5ce1:0:b0:6e8:9394:cbbe with SMTP id
 6a1803df08f44-6fb08f857b3mr243648986d6.20.1749507952233; 
 Mon, 09 Jun 2025 15:25:52 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ac84b5sm57359966d6.29.2025.06.09.15.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 15:25:51 -0700 (PDT)
Date: Mon, 9 Jun 2025 18:25:48 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 08/13] migration/postcopy: Report fault latencies in
 blocktime
Message-ID: <aEdfbKjU_SjPA3lA@x1.local>
References: <20250609191259.9053-1-peterx@redhat.com>
 <20250609191259.9053-9-peterx@redhat.com>
 <aEdanIDLjSR4szMo@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aEdanIDLjSR4szMo@x1.local>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 09, 2025 at 06:05:16PM -0400, Peter Xu wrote:
> On Mon, Jun 09, 2025 at 03:12:54PM -0400, Peter Xu wrote:
> > +static void migration_dump_blocktime(Monitor *mon, MigrationInfo *info)
> > +{
> > +    if (info->has_postcopy_blocktime) {
> > +        monitor_printf(mon, "Postcopy Blocktime (ms): %" PRIu32 "\n",
> > +                       info->postcopy_blocktime);
> > +    }
> > +
> > +    if (info->has_postcopy_vcpu_blocktime) {
> > +        uint32List *item = info->postcopy_vcpu_blocktime;
> > +        const char *sep = "";
> > +        int count = 0;
> > +
> > +        monitor_printf(mon, "Postcopy vCPU Blocktime (ms): \n [");
> > +
> > +        while (item) {
> > +            monitor_printf(mon, "%s%"PRIu32, sep, item->value);
> > +            item = item->next;
> > +            /* Each line 10 vcpu results, newline if there's more */
> > +            sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
> > +        }
> > +        monitor_printf(mon, "]\n");
> > +    }
> > +
> > +    if (info->has_postcopy_latency) {
> > +        monitor_printf(mon, "Postcopy Latency (us): %" PRIu64 "\n",
> > +                       info->postcopy_latency);
> > +    }
> > +
> > +    if (info->has_postcopy_vcpu_latency) {
> > +        uint64List *item = info->postcopy_vcpu_latency;
> > +        int count = 0;
> > +
> > +        monitor_printf(mon, "Postcopy vCPU Latencies (us): \n [");
> > +
> > +        while (item) {
> > +            monitor_printf(mon, "%"PRIu64", ", item->value);
> > +            item = item->next;
> > +            /* Each line 10 vcpu results, newline if there's more */
> > +            if ((++count % 10 == 0) && item) {
> > +                monitor_printf(mon, "\n  ");
> > +            }
> > +        }
> > +        monitor_printf(mon, "\b\b]\n");
> 
> In the review of the other series I posted, Markus pointed out we should
> avoid using "\b" and suggested a better way.  I fixed it there, but I
> overlooked I have this similar use case in this series.  I'll fix this too
> when posting v3 with similar approach.

Just in case I won't need to repost again to pollute everyone's inbox..
this chunk now look like this:

+    if (info->has_postcopy_vcpu_latency) {
+        uint64List *item = info->postcopy_vcpu_latency;
+        const char *sep = "";
+        int count = 0;
+
+        monitor_printf(mon, "Postcopy vCPU Latencies (us): \n [");
+
+        while (item) {
+            monitor_printf(mon, "%s%"PRIu64, sep, item->value);
+            item = item->next;
+            /* Each line 10 vcpu results, newline if there's more */
+            sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
+        }
+        monitor_printf(mon, "]\n");
+    }

I'm making bold to keep the R-b for Fabiano as of now unless there's
objection..

-- 
Peter Xu


