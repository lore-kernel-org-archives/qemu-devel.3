Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 224EEC5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 19:46:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ww3H9-0003e1-CG; Mon, 17 Aug 2026 15:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ww3H7-0003di-Ug
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:45:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ww3H6-0005IY-JJ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 15:45:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786995934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQjG+EGgsSGsoG1yH3ZHHzFF3GH7WgXKsAz3vvpRiqU=;
 b=YxH1dGb7b7HSXewYLTKVU2EjwK/gf+Ib9Ps11L4zU8Ie0mtAE2u18Bpwnsg4b8HgucTi5a
 pNNwXpgOCP/5eNR9ZqRqz6+HQqHRC5ofkx1X7Ci1gYwjyQcwQv8Z9HVddL/QlsQ5Tj9U8u
 BrnLoN1T2lzACyvM06XCONZWTCfeLbY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-1gmDkvk5O1O5mHhJSR2bYA-1; Mon,
 17 Aug 2026 15:45:33 -0400
X-MC-Unique: 1gmDkvk5O1O5mHhJSR2bYA-1
X-Mimecast-MFC-AGG-ID: 1gmDkvk5O1O5mHhJSR2bYA_1786995932
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 56BA919560A2; Mon, 17 Aug 2026 19:45:32 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88389180034C; Mon, 17 Aug 2026 19:45:31 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 7/9] docs: rust: update for new-style build rules
From: marcandre.lureau@redhat.com
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
In-Reply-To: <20260817134538.924615-8-pbonzini@redhat.com>
References: <20260817134538.924615-1-pbonzini@redhat.com>
 <20260817134538.924615-8-pbonzini@redhat.com>
Date: Mon, 17 Aug 2026 23:45:21 +0400
Message-Id: <178699592135.3562558.3146619541530008775.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NxrTmqk/lx/3pzsm9lYUml1Zq9bfFnLduwPh2qbCi44=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqg2TVDcVLbU75QbAKWQlFOMdhQXvcU82IQDkJZ
 9gD82IeULCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoNk1QAKCRDa6OEJdZac
 5a+cEACgV0Vq9+8BgrHugYSLZp1zPXvqNWf47JcunLpewUKHUYYzistPRfraGmS1QmPfujr2QF/
 LDOMJYACEqN7m7jtoEybYT2ik/7Svc13UvreE5kY4hAmRkEIHMa1xXLszNczkfAZt2RfwJdAko+
 xHdIMTG+GBM3fwzg7gOgQs/odu2871BB03xFmEK2YTf5CA5GDa5UaMnN72ZoHsc5wbu65MtD2jo
 jpnwrg55VWJHWp5/gc/Cb6dlAHFtRs9OVkzDMkqFEBh9FFB8yDc6t3vgctgvFxc3XyzSGs6+UDW
 WjRXgTvhWPgozf7XHaxAGIN7j8MnHTkVjb3lKI6gLP4JQivXF2JFNyn2m2MurYRebXd9Enp0q05
 uB9B7rskYYk/qhqv+UtcVkmiV/Ds7S/lDIl/Tjuhgahji2EkX9O4wkO5Wzq3LYenaa/x/cYwP+m
 QYgeTeM9JGpZV4+VsQtP6dgYb9gmbbychxLaaWLiNZJiLJnnzlRKIKIFlKycw1rSIs8PWyzSZQS
 MmwTM0OqGmtdBJVOMb6RJAlDcPA2ckW7Oma7w1nmukvBjagCoJfpPJBfmoeowz3QWRyLjeDFw8s
 QaNReHPPoTJnmmeNzXWBxdlYsaf1VcDr+AVOHwTYcwNyRqjAxsoYuuKi68Bm2a+ydiLXehrhUSB
 Em8LoJTSA2IoFUA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
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

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-ID: <20260817134538.924615-8-pbonzini@redhat.com>
>
> diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
> index af142c4a6945..6ebd4d334316 100644
> --- a/docs/devel/rust.rst
> +++ b/docs/devel/rust.rst
> @@ -21,15 +21,11 @@ invokes rustc directly, building static libraries that are then linked
>  together with the C code.  This is completely automatic when you run
>  ``make`` or ``ninja``.
>  
> -However, QEMU's build system also tries to be easy to use for people who
> -are accustomed to the more "normal" Cargo-based development workflow.
> -In particular:
> -
> -* the set of warnings and lints that are used to build QEMU always
> -  comes from the ``Cargo.toml`` workspace file
> -
> -* it is also possible to use ``cargo`` for common Rust-specific coding
> -  tasks, in particular to invoke ``clippy``, ``rustfmt`` and ``rustdoc``.
> +However, Meson is able to consume ``Cargo.toml`` files and tries
> +to be easy to use for people who are accustomed to the more "normal"
> +Cargo-based development workflow.  In the case of QEMU, in addition,
> +it possible to use ``cargo`` for common Rust-specific coding

it is possible

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


