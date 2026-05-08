Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477ACCD37AD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLMys-000663-As; Fri, 08 May 2026 11:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLMyl-000622-0l
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:19:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLMyi-0003cF-S5
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:19:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778253539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xJYUOUHC3BjwAL8U/s9zGrVjG/MnAoPyIKWyLb5cRAg=;
 b=UU+Lk0306Totv+2tWN7aGtvF6IKv+S+UjRUEW8019lfnjdg44oYJbOb665aVyvzA/SDqVQ
 mUkZRWRl/B08/KxyGLT8sZwLge+bilIoC8fEVVAJPDBIr5C1W6SCB8KUXpRC+nMxIi4oOh
 NWk5IKFVM7pcP4PK+PBzhwtzUuW9Y3Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-qh6Ln5gTN96BTuYrJcI-KA-1; Fri,
 08 May 2026 11:18:55 -0400
X-MC-Unique: qh6Ln5gTN96BTuYrJcI-KA-1
X-Mimecast-MFC-AGG-ID: qh6Ln5gTN96BTuYrJcI-KA_1778253534
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0959A180035D; Fri,  8 May 2026 15:18:54 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF50F3002D2F; Fri,  8 May 2026 15:18:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 10/10] qom: drop user_creatable_add_type method
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20260508112429.643360-11-berrange@redhat.com>
References: <20260508112429.643360-1-berrange@redhat.com>
 <20260508112429.643360-11-berrange@redhat.com>
Date: Fri, 08 May 2026 19:18:29 +0400
Message-Id: <177825350910.389613.10759707468624591000.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=814;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=M7z8wkh74TFDyh+0uqonv8hhAsweFFM0XL5+HEaTBiA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp/f7JT5CNSow/paexkPfD6H4YjyOile1/1bNGn
 mnNBrGpGsuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaf3+yQAKCRDa6OEJdZac
 5bWED/90vHoTetzrlXcH8uMw+uA/uEevya8yqUrbt/1G2nW9fdfksFOxr5M9P+C1BycxcOlZYvh
 vu+88tTqHIgbqgqFYv926mR56UVBszjmSN1MIKCiSRe4YbgoP3FcNH9gSd0r9Ea9QVqEIq87UP7
 40Yx8gFNYRD6TUItOk13NuwhWvR7B1lShMQwmB091dnKR3pjPkHQzcxJjPHnpJXKWG2qvV13lE4
 vMcvwPsP4K5jWkSWYEGPwDAjA/hDxrQLwJ79dylXi5CLhKtF2s9Cls+OD4UPpyJdMqy8xVHxIJ2
 hIysCbp3Lk1PzzKGsRsZIZZd8aDfLIAkxDpBdRXNHEkH76QyzCZVbNhSdT0xZWfUhTCVovgShc6
 93mrC0dWxIzUDX+oE9qp8/Sp0zBHVEIAJkiltRzW/AbbE2C7/gIwBtn0iQj+C8BMJr4bf4ALG4q
 44xKuW6AyYO4Os4AMsLsxo9RPHs1p/K4OyzbHDAHuUuJVzMqINpnhTBZW/uMzIej9d6iBYkIUfE
 I6mcjgxeb6Zq7hNRCWncr6tuy6BlNJHIvwpDWqwhy0Su0x7CNg6odhjMO9ACbc0sdJbwAdeBser
 vh0oYc8NrkxKznhSBYMFWV/VXNYmeBDuDXKjhm3B2BIi3xuvwuZQQO26y8izQvLKx9OLPirfOAL
 qXwms8xEZXL567A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, 08 May 2026 12:24:29 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
> index e0a3cd8d0f7..7080f85f95f 100644
> --- a/qom/object_interfaces.c
> +++ b/qom/object_interfaces.c
> @@ -44,75 +44,11 @@ bool user_creatable_can_be_deleted(UserCreatable *uc)
> [ ... skip 25 lines ... ]
> -    if (!object_class_dynamic_cast(klass, TYPE_USER_CREATABLE)) {
> -        error_setg(errp, "object type '%s' isn't supported by object-add",
> -                   type);
> -        return NULL;
> -    }
> -

It's worth to mention in the commit message that -object and object-add
go through QAPI ObjectOptions list, and thus don't need the
now gone TYPE_USER_CREATABLE check.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


