Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5A4C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhRA-00085h-Pq; Wed, 19 Aug 2026 10:38:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwhR5-000827-Fw
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:38:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwhR4-00052o-6c
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787150313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQB4lLuHk5lN9xm4QCqKpIaDWaF09qA6B46fgul0+1M=;
 b=RhfSNlxiDHZkth8t3DmR9TU1MXPbaDpjwvvOVbM9vBRibzpVihTX75+9wqqPlIrCm0oDRv
 yK1azcqvABFij9Fh5zHa3dbQYslRsY77vgvbucc/D5nBvNjTm+M5jFr0B053yhE8RgZg8R
 3bw1FlFnWJtLlV1NCaqHZKQt16O1ZTU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-IhT6KaMtMRml5YNSnpNyPg-1; Wed,
 19 Aug 2026 10:38:23 -0400
X-MC-Unique: IhT6KaMtMRml5YNSnpNyPg-1
X-Mimecast-MFC-AGG-ID: IhT6KaMtMRml5YNSnpNyPg_1787150300
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 962FF19560A2; Wed, 19 Aug 2026 14:38:20 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 92234434; Wed, 19 Aug 2026 14:38:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 05/15] hw/isa/lpc_ich9.c: convert ich9_lpc_initfn()
 object props to class props
From: marcandre.lureau@redhat.com
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260819133816.3497033-6-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
 <20260819133816.3497033-6-mark.caveayland@nutanix.com>
Date: Wed, 19 Aug 2026 18:35:56 +0400
Message-Id: <178715015699.1965216.5908963098435249264.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=234;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KVEEh1ZdJHiK/Jo4FT2jzvaDkzArcMZwuBM+DJR5Xe4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhb9R/HJZUqaOxn6ftjI6SGfwqc12+FnqtpTqt
 H8YwLwtXKaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoW/UQAKCRDa6OEJdZac
 5VqZD/4ojJjgcxraf7EovdIXCCctwhTwwOpiOe9bWCRAVrl8qp+3dX7WnOd7jm0nvp97ZRE3ivY
 8STu3U8RLyyV0CeR15mRCaSC/lkR80RxLHiuuA21S28oHSqHqyfFwGhU8hu4AYZepiV75DeJJXz
 1lUuc+2xB6CSThvbH5hLUJTDbmBAipdraGtyciVmpx0AB7wThh2QPiCaTcrE1IdzpXSSRf+qLQI
 +0FH1xBUipu5AnWsHIsuTKspnR4Tt+KVPJJOaA89DZGd1rJDQS0+nCkqOkbEjL/nheOOWvbedxH
 PVHlaDX9dtnm/aMV0eayf/YPtVJYgGEcCsPvaC0gtZemlJQLaJsPDjDzOyg1NrPCWOonVEUxUuc
 xXQ+luCoqf5e2UVtdTYpAalvloOm0oHe9Gr64lzh91PFjwXh0V5IhTQR6zROOHxarsGDWi9AV4v
 Yb0kGjkNP5FkG3BqsAw7PRKRjsaVmr+6wMTgeYknoEKvtbA8Hr1QNpeJQJLHcLRGcS22/0ZG3ct
 IKbHNPnRpem6oLmD7n8uSpwjipQKJatYbP27SrazGHeQFUzebBK1PxLPvgTULIlzxsVcmjHXqIr
 +yBa07XPKbagIx6KpPjU0kiwG0wdCwmeybTCcMhdABHLJBLbg0gooWkPpbeafmLjTQA0DDffNs/
 mZMMBEp2xcL5NYg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

> ICH9_LPC_SMI_NEGOTIATED_FEAT_PROP can be promoted to a Property since it uses
> standard uint64 getter and setter functions.

But it was read-only before
otherwise, lgtm

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


