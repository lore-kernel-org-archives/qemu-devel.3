Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F7A8CCA462
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI00b-0001NE-Pw; Sat, 17 Oct 2026 04:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00S-0001Mj-Iq
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xI00Q-00078k-GK
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 04:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792226584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hueLzsBykDlDKojZ1Ypp21AAez9LfRmRewEuHclFky0=;
 b=J9zJgHE07IbSPe/sIvOQZu8P/V0enKZ3H7UAWOcKFF0qrv3UIY+sjF+AHN+VEB+ye0vSNT
 VXntXKfH0tKk2Sx14kOp5eSM5h9nfJHfLj/IVHbGUuAFtZPiLkckZ0OQSiYFaEAj3555qb
 ZmtPgPx+Rufp6+UTnFgczjyZgLmM0lg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-IgJ4jL_JP2-yZgyuPC_CYg-1; Sat,
 17 Oct 2026 08:42:59 +0000
X-MC-Unique: IgJ4jL_JP2-yZgyuPC_CYg-1
X-Mimecast-MFC-AGG-ID: IgJ4jL_JP2-yZgyuPC_CYg_1792226578
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA57618004AD; Sat, 17 Oct 2026 08:42:57 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6010F195608A; Sat, 17 Oct 2026 08:42:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 01/23] target-info: add target_heterogeneous
From: marcandre.lureau@redhat.com
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 anjo@rev.ng, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261016181410.191743-2-pierrick.bouvier@oss.qualcomm.com>
References: <20261016181410.191743-1-pierrick.bouvier@oss.qualcomm.com>
 <20261016181410.191743-2-pierrick.bouvier@oss.qualcomm.com>
Date: Sat, 17 Oct 2026 12:42:48 +0400
Message-Id: <179222656890.1619676.18378047665538724984.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=468;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LRveJtHYr2pYt5kKDckQEvlsCYSvpx8lLtQpdYB+Fys=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq0zULMnBsGQxBiHKowyX5eH1InYr21RbqfgklE
 wm+/il5TPiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatM1CwAKCRDa6OEJdZac
 5WYdEACWuJyAnpNNiSA82pmgR1EXJitu24CVSkfpys3UZh6w4BlL7Ze+FnZ2qAaf9dq0waeKAAo
 pcwIwrI6okeKOdcTzCaXb0SzQO/Nn1SvhrkP21W2jPKcDnvb+SZKLrcK0ZwRa5hO5Tfm6EXzkTh
 Kr9oBHBds+SxuZONfvmFqr9h01VIEAsj/oELPMeHZMJzyF1cmjv9GSSMPhkXHHyWWfzdFv4PThX
 N6NVWGDeTwfMiv1NmQYWDTUzKVqnM/Z51TBhWwuJSadI2OCo7u8lmaiApHPjfzODdDGm2+v9NwM
 CO92h49W1zIw/vjFQbYMuDnFQd/8m8i5jOP81fB4J7PkA09AX8k06V9rrKNpx37mlKJY1NlFFqq
 9iufIDJa3A2uxb/CYFPprGu/aaZmeoKAxIrJdwwKDOpZSN6iJyEpFgB8hIyLinNDtdtHJ3H9g2i
 Fx9cdoQl/hUZZy9PozkN+++uNxFkiwWS1SObUe2syFXXWv3/ery//Z8fTEPlN/geI4hkQs/PZCO
 U+SrYo185cKbWxkKMdJSuPxpqOQFfHonfCjJaJ5IPpzr1Ee18hLH1wvpcDcWbHHxtk8PdqubKuC
 D9sZKzhfd28m4ckv3tL+0X1ouWv3MqOpuqw5ISQNAECqyXULjWPiNcoWqUaK6bNnqi3RmQZh8re
 0e5EXNZTjMvGnLA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Fri, 16 Oct 2026 11:13:48 -0700, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> wrote:
> For now, this function strictly returns false. We'll turn it to true
> once heterogeneous emulation in supported. Meanwhile, we can use this to
> add various checks and asserts over the codebase as reminders about what
> we'll need to modify.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


