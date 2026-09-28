Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F3ECA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBCqD-0003ZW-Qv; Mon, 28 Sep 2026 11:00:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBCq0-0003QE-1u
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:00:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBCpu-0000OC-T8
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790607603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5W/s7tjkAJzUjpj3kjT0RssVRMseMpm5dxttD/Pq2Tg=;
 b=fb96H8d7bzN+FnPo845gEsNXTNuDArnNR3TyWIHzpqCR+7CYNM7H493n0nHc7VENxWFnNx
 tZwhA79QLl6yNVFwHCtHMWE/2CaCMT0wpaxnYV8WEF58x0dY6DL+z8cF5NJ5xLD1qnLjgf
 vR0JNNBAEhcWJs+Ec1AWFiiTh8zLqKY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-Repx0BeNMvmh8FHWMioF2A-1; Mon, 28 Sep 2026 10:59:59 -0400
X-MC-Unique: Repx0BeNMvmh8FHWMioF2A-1
X-Mimecast-MFC-AGG-ID: Repx0BeNMvmh8FHWMioF2A_1790607599
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53124d6a362so96580541cf.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 07:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790607599; x=1791212399; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5W/s7tjkAJzUjpj3kjT0RssVRMseMpm5dxttD/Pq2Tg=;
 b=P1oHy9OMFj27z7CO8eALG7qqMcfw/DS6z84XZMCIzhItonjf23vabvK9F/1diEx0yo
 oVAXICRtv+WTJvhRTTWQTxXBdUcopPbmuKHh1+J0aoG4TxtWwe9YgKeu7tGmWuu+OFOK
 osCl2Lgwg5ONSxqQBS3PpFRdGubI9zK9l+CYmXTVp89ZDcqu4qOR7fImumZKvpnZnjbi
 lE9N7Ba3ftBvasw6ss4zKRlV5pO8GKEFUVLSl57luzSAF18UQoAoaNi8Qaq0dwUlPMGC
 USoOmvRo+ReE9bjlmzVtJTLdesR/4XI1krv151ez/u8MPt7yXQnnkuJHMXKtThJgS2no
 mXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790607599; x=1791212399;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5W/s7tjkAJzUjpj3kjT0RssVRMseMpm5dxttD/Pq2Tg=;
 b=TZqRnq3ULydpvsX3vMqpELnFC458ejb1CeQbv89mGu5bADYW4yr7a9wfdr+sZkXqvN
 ElAIVg2gMbqTcDWWTzJjDrVlA01TaE5zldzR/JuRmFGxyfrZOeP1RVj1wvfMDAUB/LnW
 10cr+pQIl4ekwil6p4WS6RilusA9g32htQsLPgAsq2rLCtcr3SMiS68V6wLFHXMI9/Kj
 w8cUwVybwVIJ0xzR1AjoNaSJb77pW1HM0lhz2WPKqSftqefnIehuFKS48YK6f6lDcg/8
 pnzsDWQt6/PkAjXYo2c916F+rcqlFAy3ADXxcGGKEJupwtJjGM5xosEJM+WwkNiFrvx2
 xwng==
X-Gm-Message-State: AFuF++lNBQwhMyeW1HyWIa95iTcZv+h0cTgdmv8QNcDkoR5BG7Y47yfx
 e6JCE8+jkPp3MBbXR+oYYwymSPek0FhYOTU7lAo7bc9/5nMozi57378iwAzUELWAQWKf6jNr/74
 Nax7HMIanyNm1KzQXfCubqNlQRipz2IMmtl3b534mF4CdF85ZWmBkmyLn
X-Gm-Gg: AYBFou0bF+M5oRRawgOpqreM/iMoaUorqpYYuoUix8mSfn1zPU0dgJT84Z3dSziG6Ca
 4R46gBeeelCsD/e0PYXgiD7+W1qbLIeSLvEKNzkkmn3b4iuKYYZwasRx6VOctnhiE03Kob9zlBH
 146pnxygPblEKDGX6hZDjjo2Dk8ZsIAhPzUvaOZhql+AFwOCG08OusxlGtSLO8W/8HT+ujKoOaS
 ZHaEWtldbMR6jyBeZaQuyzqIuGTxn/Ys/R6pf+V4Bykn/pHf3mWhve17YjPistY/tbvdOj2HvTQ
 uUgLUoLmwXF4RO6ZboxzJWCyAgp388iwLEstAesZMW9U9D+jBTQU58VpqCT0kNGf6IQGuEA=
X-Received: by 2002:a05:622a:1341:b0:532:a96d:5957 with SMTP id
 d75a77b69052e-5330dd31e0emr213998941cf.51.1790607598535; 
 Mon, 28 Sep 2026 07:59:58 -0700 (PDT)
X-Received: by 2002:a05:622a:1341:b0:532:a96d:5957 with SMTP id
 d75a77b69052e-5330dd31e0emr213998131cf.51.1790607597880; 
 Mon, 28 Sep 2026 07:59:57 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91441300032sm65603306d6.37.2026.09.28.07.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 07:59:56 -0700 (PDT)
Date: Mon, 28 Sep 2026 10:59:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, bchaney@akamai.com,
 mark.kanda@oracle.com, philmd@oss.qualcomm.com,
 vsementsov@yandex-team.ru, maciej.szmigiero@oracle.com,
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com,
 den@openvz.org, sgarzare@redhat.com
Subject: Re: [PATCH v7 15/16] tests/qtest/migration: add vhost-vsock tests
 for cpr-transfer and cpr-exec
Message-ID: <arqA6wEXGnwOJU-X@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
 <20260918-up-vsock-vhost-v5-v7-15-6ef9ef033c35@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-15-6ef9ef033c35@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
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

On Fri, Sep 18, 2026 at 04:47:06PM +0300, Andrey Drobyshev wrote:
> Run the existing cpr-transfer and cpr-exec tests with a vhost-vsock-pci
> device attached.  There's no guest involved which is driving the device,
> so here we only test the QEMU side of the handoff, i.e. the vhost FD is
> preserved, the device ownership is released on the source and re-acquired
> on the target.
> 
> The tests need /dev/vhost-vsock on the host and a kernel supporting
> VHOST_RESET_OWNER for vhost-vsock, they are skipped otherwise.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


