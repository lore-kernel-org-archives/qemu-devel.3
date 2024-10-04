Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E987ECF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlJK-000673-T0; Fri, 04 Oct 2024 12:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlHC-0000oq-OV
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlHA-0006Wa-RI
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOYQxlb8dWb3hQAPR7qPAEAmjAvpcOZoKc0Lj5UkEYs=;
 b=JtoQ4w44vROSQ2tPoBG/oUbpTYRGZORJxdmI2JVkYW04E4QZlRHauufdCBiap1TLg2LbcD
 8o4IViGsFkrpZ2txjYDTBuhfMhTYJEeQnjo8V1IetjzLKOqRa5o53gfgTjSxMP26QbA019
 +sJEVMAcYXbmHk1aCD4E8p3RmsliyEo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-403-Hism51xiOWmITFYCq6oljg-1; Fri, 04 Oct 2024 12:35:31 -0400
X-MC-Unique: Hism51xiOWmITFYCq6oljg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37cd1fb9497so1691082f8f.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:35:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059729; x=1728664529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fOYQxlb8dWb3hQAPR7qPAEAmjAvpcOZoKc0Lj5UkEYs=;
 b=Fq8Nzm9jmf/qm3Z6S2fIn4MvGp1GblDMwpDqZh8I1GMB5LwLJM53bYsOoNJO1EptmQ
 rL+JK88q0JDkfIRFbNsY7q/GPOXy64TMwTU/eDy79GULagjFssUDoEhFxtJA42PS88DK
 6+gwa4TpW9InU/CaFlLrWgNgToy8YIKc1+bq7+XTKvi6yjWIpKhAY2TSkcBm0sVk/hXq
 xA2ELAnI0w4jppU3Y+hsHbKvWsYHgmEDG1d+2QYYYj3Z3RMfb+IoFZTCvVPyZC9OYcoG
 mcxYLY/fqudqBdxpMdUM4tSRWAe0EW04L3MCQDYibko43QT75dsPTHX5uABAnrSp2mrZ
 +P6A==
X-Gm-Message-State: AOJu0YzTHfkxFU1ouMhA5m7DP5jKzMWRaz0rrg1L2oKhA3ZxxCHQ/vyd
 QDtgbG/31JSkn47plIppA8UbszZ5RnZZFhMg2Z3i027y3gBN5tXO8v/Syx9oySLTq8NzYmLcduS
 DTd2cVqsPd909THHbYGxnHFT8iXRpIY8NxbD0TZGbDPMaUB5sLawpNazd5XT5lB39JGlPHE4bbB
 PMx4WaXItiEd+RXAMm33BMQp6NcejPpIvbTUgzUNQ=
X-Received: by 2002:a05:6000:4027:b0:37c:c4c0:4545 with SMTP id
 ffacd0b85a97d-37d0f6a273emr2756055f8f.10.1728059729276; 
 Fri, 04 Oct 2024 09:35:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXclZtSxrABT4Js56F5JgVI3AVPXr7Hp3OvWFOa+a+Md33A9vrxn8IFmtd5Ezw0CXC8fLSzA==
X-Received: by 2002:a05:6000:4027:b0:37c:c4c0:4545 with SMTP id
 ffacd0b85a97d-37d0f6a273emr2756027f8f.10.1728059728757; 
 Fri, 04 Oct 2024 09:35:28 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1688a486sm55812f8f.0.2024.10.04.09.35.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:35:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 23/23] qom: update object_resolve_path*() documentation
Date: Fri,  4 Oct 2024 18:34:15 +0200
Message-ID: <20241004163415.951106-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

- update doc to reflect that @ambiguous is now set true or false on failure
- specify that @ambiguous is nullable
- use some gtk-doc annotations

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20241002080806.2868406-4-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qom/object.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 13d3a655ddf..2af9854675c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1569,8 +1569,8 @@ char *object_get_canonical_path(const Object *obj);
 /**
  * object_resolve_path:
  * @path: the path to resolve
- * @ambiguous: returns true if the path resolution failed because of an
- *   ambiguous match
+ * @ambiguous: (out) (optional): location to store whether the lookup failed
+ *   because it was ambiguous, or %NULL. Set to %false on success.
  *
  * There are two types of supported paths--absolute paths and partial paths.
  * 
@@ -1587,7 +1587,7 @@ char *object_get_canonical_path(const Object *obj);
  * only one match is found.  If more than one match is found, a flag is
  * returned to indicate that the match was ambiguous.
  *
- * Returns: The matched object or NULL on path lookup failure.
+ * Returns: The matched object or %NULL on path lookup failure.
  */
 Object *object_resolve_path(const char *path, bool *ambiguous);
 
@@ -1595,10 +1595,10 @@ Object *object_resolve_path(const char *path, bool *ambiguous);
  * object_resolve_path_type:
  * @path: the path to resolve
  * @typename: the type to look for.
- * @ambiguous: returns true if the path resolution failed because of an
- *   ambiguous match
+ * @ambiguous: (out) (optional): location to store whether the lookup failed
+ *   because it was ambiguous, or %NULL. Set to %false on success.
  *
- * This is similar to object_resolve_path.  However, when looking for a
+ * This is similar to object_resolve_path().  However, when looking for a
  * partial path only matches that implement the given type are considered.
  * This restricts the search and avoids spuriously flagging matches as
  * ambiguous.
-- 
2.46.1


