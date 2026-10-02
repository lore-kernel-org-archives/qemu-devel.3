Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2040CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgzc-0004du-Vc; Fri, 02 Oct 2026 13:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxc-0000FC-Jz
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgxb-0003gb-8L
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=odsg6seDL1A3x8nMCICjbWM1bqx8pH3GiORy5lEZxIs=;
 b=APdBfvTPYebxuQKT4ZNSci1Cq3kEENfBUpK1Bg71jOlp5J0Krj4IhxRFZdHmu77bDBEVnY
 nMwdBPJ0YXC4gZzIiP4KTr4Re1I4oGwOm/xh7U/EH4RX1jAeAjZ+W49lza3yK+U0Q6BsgK
 GwzSZ4KG6g9Kcgvi8u1KG4a/jLTTthc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-tB0D-qP7One0EVL5uzWu0Q-1; Fri,
 02 Oct 2026 13:22:13 -0400
X-MC-Unique: tB0D-qP7One0EVL5uzWu0Q-1
X-Mimecast-MFC-AGG-ID: tB0D-qP7One0EVL5uzWu0Q_1790961732
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 033DD1955DDC; Fri,  2 Oct 2026 17:22:12 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3792330000E4; Fri,  2 Oct 2026 17:22:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 18/28] hw/tpm: mark all TPM implementations as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-19-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-19-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166127.3025252.52837397415486624.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=311;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=5ib7kbnvMQLEGT4quBiHZZ2xblFgOBBV7yGe0Fw3Eh8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gCa0cJy16Wm8FxYIqcRoer4PF17CoBL3y11
 1AUOS+zCLCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAgAKCRDa6OEJdZac
 5SmxD/9UFyXaFIeiqXGMM2zVmi7AkR5hpeBWSCU9yDDbATqMKXA3Ey7hKwxCx8t+KRLdwudNtxI
 o1ziuFYsn+WWmZwAU4gWuv12PiKjkGx401ZKI0DLyFTZU18MUCa+Y2xCEMcCcFLP9djc/KB2hSE
 ZIbUiUqzF5lPVBnmXzlbw9ktpxstl9ycinv5Kw/XWdlWMFJRuZVFQY68XQo5PBxYkwZQt60DnQ1
 XOsvz1xDFUBFu/DFqASYR6yq48vaSlatcqiUhowGgmY+/BO8enodwLO/wyXLz/p1f5lkEzcuSIW
 DBqFweDnbPqE9yUcykSiyS1UCvCBEVhuggqZjumDA2fFpH8qoorePuvUPVrsUMBHzmQhvwCP7lg
 53YiP1Z25rgudsIFFGAJI8wyLUu69bKO0ht88tyzcp+61+XDOYP8ooQUBQZ8MDKp09FP1Yb1CZB
 Bb1Yr74cG/YrRhBDRFhgP4vxjqig7E5o3zJIFGHRY+kZEfE3m3FUI1KodddfGrwPZGvjHR264PM
 eWX0Vx1J+m2Nma7ID9ZyPzoJvu9quUz3c65NkYnz/m+2sN0ryJUj/QAev/pveFbdmVA8HtQ4BTE
 eLM1VCaZkbZqNL0cLkjJOnyb8phNbf6Wjfa2nGu2mWEBgNMxTeDhHfsBK3OQxUZIlVqGMrwRcj9
 G+W6tP5K0QlWstQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 11 Sep 2026 15:36:17 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> All of the TPM implementations are in scope of virtualization
> usage, so mark them all as secure.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


