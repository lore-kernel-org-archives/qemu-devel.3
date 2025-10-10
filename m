Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50917CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7EmW-0000fj-R8; Fri, 10 Oct 2025 11:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7EmI-0000a1-V3
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:11:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Elh-0004CA-Re
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760109048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vpOG7lTDLWHSKWSO4AEYXx9n/+p7b8N9rehUHPIdpTs=;
 b=Y/3YwBgwql5o60FSREk77c+T6mQe3s2WKa9BEUJbnJwV5VwVUz38Ta3MA0EyJYATnUifWs
 m+J9DIIUaZdHWWcdfOX5nLlR8wn5GLRFFmozLY1HaFzI1NOUikAeN2hX9EwvJIcPXeLl4m
 d6Npz81tOtelobtgfQk3hIVcjHf4yug=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-bFJzWbDTM86pdD_3eJLcZQ-1; Fri, 10 Oct 2025 11:10:47 -0400
X-MC-Unique: bFJzWbDTM86pdD_3eJLcZQ-1
X-Mimecast-MFC-AGG-ID: bFJzWbDTM86pdD_3eJLcZQ_1760109046
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b4ea3f1c12eso290765966b.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109045; x=1760713845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vpOG7lTDLWHSKWSO4AEYXx9n/+p7b8N9rehUHPIdpTs=;
 b=cFXcl/Qz25hF/Vp8q3SyHU3mXIo2HRUAmuyFmD5K4BzjNqIR4q/0V2TnymAmoObdJc
 ijKZCfv7G5g0yusUS7rrp7nR1+6+bVfM+SjnFu29im/MIRg8xxJ2m1aLywWfF1EVoYw0
 Eixh+gLi5OI9wixZe9wJm4/CcsXvNtNTbTiJ03oorll+0C1v9StYH2yMN5IO4jk9gQeR
 W1f43il9+UVqhgfLY5jKUWktGxZ+aZXmHaR6uBGys6JVRj50yKcnZk+4FMfN0i8GXyuk
 OFhKN75bRZzQ7Vctber/mibIhXQfS1rhpZTVDN6a/7UppvE1f2eN5ziSSx0g+m6EfGlY
 lNVA==
X-Gm-Message-State: AOJu0YxSyUcI2Rv9nTCK0J36y43xzXM4fQWIVTmy/BXv4kOVIwHpensd
 PvLGvzNmKatNKhEKIT00unG6bhWfZ/BumuVXECnMQ3/m1tgRdeJ08OQQSWgZxVwxS+vHdfXXjY3
 BsR3lkA9DURJzhIxkv1gt8YhVBiYjLtszbM7PDRHGFxjdPEF4AYG/LsTW+NKTzMCXCKCMqBhJBF
 9lf2pf/x5wU5YjHgsRhMjpcdgL16rCOnWWlQasFvlx
X-Gm-Gg: ASbGncsNoyWq+ZjNGV6WFU3pucv6WVnhnhY/Hjkm+QdfBo/ilkwg1CzymVQgT8MiiZm
 GzCCYPBD1b6XJdbwD+C4LUVtwRvLiPlDz+AhBnbRjMy3PcHemXA4BYh+0+Xmzpp3zB6cV7hBGQC
 HVj8m81TSZ3OaLEC7CQvG8EED9wFgulbB7Gcqe43O7MYgx782XRRV8H9D98BAQ/m7Gj02R27PFj
 dbXZqKaEM+ykEHKvkLw7rCypitEG6ttWmvCvnlflLE92uwJcbRAYerx8uwasSs2y8ZvUoaFsGDd
 T0FTllLSGKHZMJCtXgdKaJISsg96Mpqca/X71xUMFi4yClc8rvpQsEb8+w/UdLhP9a1kcIFgPc5
 IFRI+j7yL9wcPwaEC1Fbr/jHxQK8uI7kdE1Wqy5UxCNEG
X-Received: by 2002:a17:907:9710:b0:b2e:34f1:9dbf with SMTP id
 a640c23a62f3a-b50aa48d314mr1255300366b.1.1760109045078; 
 Fri, 10 Oct 2025 08:10:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/QfEEMSOOvhANB/Xy1Xu0rDgd9YPCAmSSq26VUi3QhqkM5jdYj96nXAU/kTVoZdddJ0dJkw==
X-Received: by 2002:a17:907:9710:b0:b2e:34f1:9dbf with SMTP id
 a640c23a62f3a-b50aa48d314mr1255296766b.1.1760109044642; 
 Fri, 10 Oct 2025 08:10:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d5cad86csm245763566b.17.2025.10.10.08.10.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 08:10:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 15/19] scripts/qapi: add serde attributes
Date: Fri, 10 Oct 2025 17:10:00 +0200
Message-ID: <20251010151006.791038-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010151006.791038-1-pbonzini@redhat.com>
References: <20251010151006.791038-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Generate serde attributes to match the serialization format to QAPI's:

- for enums, map Rust enum variants to original QAPI names

- for structs, rejects JSON with extra fields and omit optional fields
  (as opposed to serializing them as null)

- for union variants:
  - use tagged union format matching QAPI's discriminator,
  - map variant names to original QAPI names
  - flatten union data into parent struct

- for alternates, use type-based discrimination

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/rs_types.py | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi/rs_types.py b/scripts/qapi/rs_types.py
index 436adcf5be6..f53b419dc2f 100644
--- a/scripts/qapi/rs_types.py
+++ b/scripts/qapi/rs_types.py
@@ -31,6 +31,7 @@
 
 
 objects_seen = set()
+SERDE_SKIP_NONE = '#[serde(skip_serializing_if = "Option::is_none")]'
 
 
 def gen_rs_variants_to_tag(name: str,
@@ -77,11 +78,13 @@ def gen_rs_variants(name: str,
     ret = mcgen('''
 
 %(cfg)s
-#[derive(Clone, Debug, PartialEq)]
+#[derive(Clone, Debug, PartialEq, Serialize, Deserialize)]
+#[serde(tag = "%(tag)s")]
 pub enum %(rs_name)sVariant {
 ''',
                 cfg=ifcond.rsgen(),
-                rs_name=rs_name(name))
+                rs_name=rs_name(name),
+                tag=variants.tag_member.name)
 
     for var in variants.variants:
         type_name = var.type.name
@@ -89,21 +92,25 @@ def gen_rs_variants(name: str,
         if type_name == 'q_empty':
             ret += mcgen('''
     %(cfg)s
+    #[serde(rename = "%(rename)s")]
     %(var_name)s,
 ''',
                          cfg=var.ifcond.rsgen(),
-                         var_name=var_name)
+                         var_name=var_name,
+                         rename=var.name)
         else:
             c_type = var.type.c_unboxed_type()
             if c_type.endswith('_wrapper'):
                 c_type = c_type[6:-8]  # remove q_obj*-wrapper
             ret += mcgen('''
     %(cfg)s
+    #[serde(rename = "%(rename)s")]
     %(var_name)s(%(rs_type)s),
 ''',
                          cfg=var.ifcond.rsgen(),
                          var_name=var_name,
-                         rs_type=rs_type(c_type, ''))
+                         rs_type=rs_type(c_type, ''),
+                         rename=var.name)
 
     ret += mcgen('''
 }
@@ -159,9 +166,11 @@ def gen_struct_members(members: List[QAPISchemaObjectTypeMember],
                       optional=memb.optional, box=is_recursive)
         ret += mcgen('''
     %(cfg)s
+    %(serde_skip_if)s
     pub %(rs_name)s: %(rs_type)s,
 ''',
                      cfg=memb.ifcond.rsgen(),
+                     serde_skip_if=SERDE_SKIP_NONE if memb.optional else '',
                      rs_type=typ,
                      rs_name=rs_name(to_lower_case(memb.name)))
     return ret
@@ -182,17 +191,23 @@ def gen_rs_object(name: str,
     ret = ''
     objects_seen.add(name)
 
+    serde_deny_unknown_fields = "#[serde(deny_unknown_fields)]"
     if variants:
         ret += gen_rs_variants(name, ifcond, variants)
+        # we can't use because of the flatten unions
+        # serde FlatMapAccess should consume the fields?
+        serde_deny_unknown_fields = ""
 
     ret += mcgen('''
 
 %(cfg)s
-#[derive(Clone, Debug, PartialEq)]
+#[derive(Clone, Debug, PartialEq, Serialize, Deserialize)]
+%(serde_deny_unknown_fields)s
 pub struct %(rs_name)s {
 ''',
                  cfg=ifcond.rsgen(),
-                 rs_name=rs_name(name))
+                 rs_name=rs_name(name),
+                 serde_deny_unknown_fields=serde_deny_unknown_fields)
 
     if base:
         if not base.is_implicit():
@@ -214,6 +229,7 @@ def gen_rs_object(name: str,
 
     if variants:
         ret += mcgen('''
+    #[serde(flatten)]
     pub u: %(rs_type)sVariant,
 ''', rs_type=rs_name(name))
     ret += mcgen('''
@@ -232,7 +248,8 @@ def gen_rs_enum(name: str,
 
 %(cfg)s
 #[repr(u32)]
-#[derive(Copy, Clone, Debug, PartialEq, common::TryInto)]
+#[derive(Copy, Clone, Debug, PartialEq, Serialize, Deserialize,
+         common::TryInto)]
 pub enum %(rs_name)s {
 ''',
                 cfg=ifcond.rsgen(),
@@ -241,10 +258,12 @@ def gen_rs_enum(name: str,
     for member in enum_members:
         ret += mcgen('''
     %(cfg)s
+    #[serde(rename = "%(member_name)s")]
     %(c_enum)s,
 ''',
                      cfg=member.ifcond.rsgen(),
-                     c_enum=rs_name(to_upper_case(member.name)))
+                     c_enum=rs_name(to_upper_case(member.name)),
+                     member_name=member.name)
     # picked the first, since that's what malloc0 does
     default = rs_name(to_upper_case(enum_members[0].name))
     ret += mcgen('''
@@ -275,7 +294,8 @@ def gen_rs_alternate(name: str,
 
     ret += mcgen('''
 %(cfg)s
-#[derive(Clone, Debug, PartialEq)]
+#[derive(Clone, Debug, PartialEq, Serialize, Deserialize)]
+#[serde(untagged)]
 pub enum %(rs_name)s {
 ''',
                  cfg=ifcond.rsgen(),
@@ -323,6 +343,8 @@ def visit_begin(self, schema: QAPISchema) -> None:
 // that *could* be Eq too.
 #![allow(clippy::derive_partial_eq_without_eq)]
 
+use serde_derive::{Serialize, Deserialize};
+
 use util::qobject::QObject;
 '''))
 
-- 
2.51.0


