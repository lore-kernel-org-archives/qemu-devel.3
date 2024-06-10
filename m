Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687F8C27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 12:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGdyQ-0004oV-QK; Mon, 10 Jun 2024 08:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sGdyL-0004n3-Fv
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 08:18:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sGdyJ-00055w-GF
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 08:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718021877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EwlXhZu2hwlpDuiHJxbxfqaBtywuRbIj+O3dyBLSQGY=;
 b=i5dBRciwG59H+uvOcBEI05ZtO8xyS3CcX5HnJqLggMJiMmFP+ey4QRX9Sua4Mcdx7FDCZA
 wlz3dMkSSb8uzDqVIJqpZo7Mp6Cosq0plQ2FhYNzko9IIzHg/yxIjTw7fkbi3eP3r01bAI
 NAWDutSiOl3UqmuDUz6BwX8S39AThS0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-5ugVHesXMGO59w8q9NMKFA-1; Mon,
 10 Jun 2024 08:17:55 -0400
X-MC-Unique: 5ugVHesXMGO59w8q9NMKFA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47CBC195609F; Mon, 10 Jun 2024 12:17:53 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.45])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BD9730000C3; Mon, 10 Jun 2024 12:17:49 +0000 (UTC)
Date: Mon, 10 Jun 2024 07:17:46 -0500
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: [Stable-7.2.12 00/29] Patch Round-up for stable 7.2.12, frozen
 at 2024-06-07
Message-ID: <l6jbovskcivkkog7lkvazwn4f4vqflbilgo63lfgwecunsb4al@iak6kurhbl57>
References: <qemu-stable-7.2.12-20240607221018@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qemu-stable-7.2.12-20240607221018@cover.tls.msk.ru>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Fri, Jun 07, 2024 at 10:12:02PM GMT, Michael Tokarev wrote:
> The following patches are queued for QEMU stable v7.2.12:
> 
>   https://gitlab.com/qemu-project/qemu/-/commits/staging-7.2
> 
> Patch freeze is 2024-06-07 (frozen), and the release is planned for 2024-06-09:
> 
>   https://wiki.qemu.org/Planning/7.2
> 
> Please respond here or CC qemu-stable@nongnu.org on any additional notes
> about the planning release.
> 
> The changes which are staging for inclusion, with the original commit hash
> from master branch, are given below the bottom line.
> 
> Thanks!
> 
> /mjt
> 
> --------------------------------------
> 01* 690ceb71936f Philippe Mathieu-Daudé:
>    gitlab-ci: Remove job building EDK2 firmware binaries
> 02* 7bc1286b81d4 Palmer Dabbelt:
>    gitlab/opensbi: Move to docker:stable
> 03* 04f6fb897a5a Michael Tokarev:
>    linux-user: do_setsockopt: fix SOL_ALG.ALG_SET_KEY
> 04* ae6d91a7e9b7 Zhu Yangyang:
>    nbd/server: do not poll within a coroutine context
> 05* 4fa333e08dd9 Eric Blake:
>    nbd/server: Mark negotiation functions as coroutine_fn

In addition to these two, we also need the following for NBD:

 14ddea7e3c81 Eric Blake:
  qio: Inherit follow_coroutine_ctx across TLS

and optionally:
 5905c09466f4 Eric Blake:
  iotests: test NBD+TLS+iothread


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


