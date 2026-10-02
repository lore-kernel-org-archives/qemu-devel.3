Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED49CA5FE4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgyS-0000nd-Ty; Fri, 02 Oct 2026 13:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgwk-0008Gy-FG
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:21:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgwi-0003Nd-38
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jrylDJpuZsoIFUUXahyTqE70K91jDraMOMDJ9U5h74g=;
 b=R5CFsTCS8ZmbkJUKZggGXdw6pH2wOgvv4BFSgUCCHBrfYHblB1LhoUtRXSfqv5acrLC+jV
 s/x4NP97Oul+X3LyeJNlZTTCVd2sEYjHm6w4FLHZb6NGd5jXCMkyK2vu2SCU6//dJKfiGm
 52/NoJSh4/BFAVm5YYPHKhCl3ZdIzxc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-6G5WWYj4Pwavoq5nivgnag-1; Fri,
 02 Oct 2026 13:21:16 -0400
X-MC-Unique: 6G5WWYj4Pwavoq5nivgnag-1
X-Mimecast-MFC-AGG-ID: 6G5WWYj4Pwavoq5nivgnag_1790961674
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A11E118005AA; Fri,  2 Oct 2026 17:21:14 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C8A31800581; Fri,  2 Oct 2026 17:21:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/28] hw: mark secure machines for x86, s390, ppc,
 arm, loonarch, riscv
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-2-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-2-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166108.3025252.9718549338852340036.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=597;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ca+dBKOXV8eblTF1UKIxDCLCnqb1+6+PKPCp8E4obQ4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gBgNVED7Ge4a3FZfVyeJ38C0I9ULQ5WCY2b
 YIjlAH9jsSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAQAKCRDa6OEJdZac
 5bd4EAC2ao/4YK3V1u4GjHkazn/6ZsYoSxnIEqPJWp1T7/d2J5MPCGyBHlyIaBQnTyWumHZzE4e
 YuaketbXl3iETQW0apS2w87kTX1duwp1IVO8IwY+Swe4svc833Za0oQnKfYUO267Y8xZQp/9BpU
 8hF37E8FJ+kqiRSBtO2+b6hb5keM9sFGZjDiwBth4dA/95vEw6PsjVKH5bxRoh0/FXeIe66nfZv
 lr2WChCZVhwaV2BgsIvIHvKrGrQMGgAseXPd1ps2X/OGBsIvAaFoXQ1Svi6mBVDCxWCb+tdFPGv
 13+65LJDDOy8/2ZrMOsKnb3YkGocX+wp7L06YuJMb6tU6Md2Ok48cOMeDyFBJTxSboYWoQfMtCZ
 1DSLqzx858E+YAtEZ7tSRPBOWOmijAhPrZBP0l11ayLXOH/LAVcSirS+xqVJEf9gUSTWRWl5ZR5
 ZzexT/7u+r1yWJAfUPygKAbuTRuntENaYWEwbud23gQKW8LxpVXZcf0xgPhBpteXMkfJBj++VvW
 KdbGkEumADdwxp/9/LWlUg+Ei1eEb1IAjO+nEpMhcodOBB7Q3dc8X/e6NnpCIKkR8RzG5tgsiEQ
 AqL0XjQchX2rYKoGYCEF440qzS4CcM3DkY+PBBTDf0bbrV2YI77tpmeSrooACeiRuGCHPKqGH2m
 L226vTermADFMvA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 11 Sep 2026 15:36:00 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> The versioned machine types are typically present for use in
> virtualization use cases and can be expected to provide a security
> barrier. The only exceptions are the m68k versioned machine types
> which are only used with TCG. There are also a handful of other
> machines declared secure in docs/system/security.rst, notably
> the Xen machine variants and microvm.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


