Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB1DCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Emm-0000o5-6H; Fri, 10 Oct 2025 11:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Emj-0000md-5W
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Els-0004En-V3
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760109061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1yOkbzuojTrlKk+buHl+5dXDqrmMnV6cjefuiyhlyQ=;
 b=a3y+omdhqycTwHx9EmsAmYpKG5rv1JLlHkjeK+oTdO9GE1L4vsoemt7fb2H9H9zSNhcWuO
 Cr3fPNaTLVOmdjtcl1Gb2HHloNWVwtd18M6Ttg9mUCVRaE6PixYYFMhBlze729NVVRZ09P
 14+u0bUcyoEf4Ug+SyB4MiRNldVujSo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-3jDyQ7E7PwaQoV0Zd-VeEg-1; Fri, 10 Oct 2025 11:11:00 -0400
X-MC-Unique: 3jDyQ7E7PwaQoV0Zd-VeEg-1
X-Mimecast-MFC-AGG-ID: 3jDyQ7E7PwaQoV0Zd-VeEg_1760109059
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b4626b2d07bso270001066b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109058; x=1760713858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1yOkbzuojTrlKk+buHl+5dXDqrmMnV6cjefuiyhlyQ=;
 b=nCh8QhKlLPdMmDAOE3+xYepzPTbZGahgK/XYc/OX9LllLjWHqFa0PFFFnOOzFiL9Q1
 L6uL9J/ANl9GMvfJtYO/mcCi3ECVkozn6WbCLuI/HM9kaHE2LTJrz7dRHbvQdc3M5W4g
 +MPb6jbPyIRYV584soxVeUKjINqpfpbXeljImVK4M9rhzTc1rMh+TQJxncptQHSzlEZs
 7PONjPFITW3L4FaZYSgSzKWv2d74ODUJMJkW/RKtBT9oRhBol9vRN3E2O9dWJyDK/yIN
 m20tn4Tm5V4apWL0v6rfg4i56c52WEe351ocScyFVnQ5s6u5hy0V2RGcTh9jcMF3HCBQ
 +DSg==
X-Gm-Message-State: AOJu0YzpNSkzCBkZVP6HR6q1d0ZBFXm0wnwYSSGDP1hf7aJ+FDf04fYr
 OUGTOe4CWKKkBHuOB5gY3nX3NYtgt5X3xEfMAXW4nF3H+Fhfq9xP2dzYDXwVWRUcWci4UA85kzb
 3K/nkQj2L0XqPmc0KVk+3ZARrmCYMff03IpVrGAIDc+Q0+QvFSeoiaDgLxV+vQFxSQqgoIRsEuR
 UriKaAyX1IDxXnzNzfmFDQF1zbx3AZA7Njeh3UaTXP
X-Gm-Gg: ASbGncuFmYv48bt5ou6Ct7CJTTDyQ5DKw7wDZ5Yi1ORz2Pg6JX928cyXIpxp1CwiSpH
 Ej9JwWVL+Lvf2a9LtVzGizOh8tm+MWY3jsN1Mxx5Ly9ajxXKvczmo8M0XTvm/zFOWKhAAV1qDy2
 vKHRtDZ+b5f6kZiIjGURaMAawFDpSCYUYPhe2X/NbKrcL9elmoKYbBTZW1W4wMDmupIqsoyCW8+
 2YwMaK/zeCrgfF6Gc9oLcLevVEpmHpZk8mdx0uu0D2GeK/TREoEP5LNetxCMPxBopEAVF2gvGPQ
 ykRweW9qzADusTPYgUGP0C49NSx2WMPZDA54h5W4waYNBoh5M1R2snok11ZIN0nHe30cDHHO6Am
 RAsXZKmlby19chTwSCRiFz+MiJrqKSFhj0OPinN6+3e0B
X-Received: by 2002:a17:906:6a14:b0:afe:764d:6b22 with SMTP id
 a640c23a62f3a-b50aa48c4cfmr1202296666b.9.1760109058013; 
 Fri, 10 Oct 2025 08:10:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVVmh/0bAHP7hdXC/LRNn8SnraAOcqmHRskIba6Qi+nb/2xvuxezyMS07uKWG40QALxvHtfg==
X-Received: by 2002:a17:906:6a14:b0:afe:764d:6b22 with SMTP id
 a640c23a62f3a-b50aa48c4cfmr1202276966b.9.1760109055296; 
 Fri, 10 Oct 2025 08:10:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d95257c8sm259085866b.77.2025.10.10.08.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 08:10:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 19/19] rust/tests: QAPI integration tests
Date: Fri, 10 Oct 2025 17:10:04 +0200
Message-ID: <20251010151006.791038-20-pbonzini@redhat.com>
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
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/tests/meson.build          |  25 +-
 rust/tests/tests/integration.rs |   2 +
 rust/tests/tests/qapi.rs        | 444 ++++++++++++++++++++++++++++++++
 3 files changed, 468 insertions(+), 3 deletions(-)
 create mode 100644 rust/tests/tests/integration.rs
 create mode 100644 rust/tests/tests/qapi.rs

diff --git a/rust/tests/meson.build b/rust/tests/meson.build
index 00688c66fb1..663c1e1aafc 100644
--- a/rust/tests/meson.build
+++ b/rust/tests/meson.build
@@ -1,11 +1,30 @@
+test_qapi_rs_files = custom_target('QAPI Rust',
+  output: 'test-qapi-types.rs',
+  input: [ files(meson.project_source_root() + '/tests/qapi-schema/qapi-schema-test.json') ],
+  command: [ qapi_gen, '-o', meson.current_build_dir(), '-b', '@INPUT0@', '-B', 'qapi.backend.QAPIRsBackend', '-p', 'test-' ],
+  depend_files: [ qapi_inputs, qapi_gen_depends ])
+
+_test_qapi_rs = static_library(
+    'test_qapi',
+    test_qapi_rs_files,
+    override_options: ['rust_std=2021', 'build.rust_std=2021'],
+    rust_abi: 'rust',
+    dependencies: [common_rs, util_rs, serde_rs, serde_derive_rs])
+
+test_qapi_rs = declare_dependency(link_with: [_test_qapi_rs])
+
 test('rust-integration',
     executable(
         'rust-integration',
-        files('tests/vmstate_tests.rs'),
+        files(
+            'tests/integration.rs',
+            'tests/vmstate_tests.rs',
+            'tests/qapi.rs',
+        ),
         override_options: ['rust_std=2021', 'build.rust_std=2021'],
-        rust_args: ['--test'],
+        rust_args: ['--test'] + _qapi_cfg,
         install: false,
-        dependencies: [bql_rs, common_rs, util_rs, migration_rs, qom_rs]),
+        dependencies: [bql_rs, common_rs, util_rs, migration_rs, qom_rs, qapi_rs, test_qapi_rs]),
     args: [
         '--test', '--test-threads', '1',
         '--format', 'pretty',
diff --git a/rust/tests/tests/integration.rs b/rust/tests/tests/integration.rs
new file mode 100644
index 00000000000..ebc17cb5550
--- /dev/null
+++ b/rust/tests/tests/integration.rs
@@ -0,0 +1,2 @@
+mod qapi;
+mod vmstate_tests;
diff --git a/rust/tests/tests/qapi.rs b/rust/tests/tests/qapi.rs
new file mode 100644
index 00000000000..f8a585e5802
--- /dev/null
+++ b/rust/tests/tests/qapi.rs
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#![allow(unexpected_cfgs)]
+#![allow(clippy::shadow_unrelated)]
+
+use util::qobject::{from_qobject, to_qobject, QObject};
+
+#[test]
+fn test_char() {
+    let json = "\"v\"";
+    let qo = QObject::from_json(json).unwrap();
+    let c: char = from_qobject(qo).unwrap();
+    assert_eq!(c, 'v');
+    assert_eq!(to_qobject(c).unwrap().to_json(), json);
+
+    let json = "'va'";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<char>(qo).unwrap_err();
+}
+
+#[test]
+fn test_enum() {
+    let json = "\"value1\"";
+    let qo = QObject::from_json(json).unwrap();
+    let e: test_qapi::EnumOne = from_qobject(qo).unwrap();
+    assert_eq!(e, test_qapi::EnumOne::VALUE1);
+    assert_eq!(to_qobject(e).unwrap().to_json(), json);
+}
+
+#[test]
+fn test_struct() {
+    let expected = test_qapi::TestStruct {
+        integer: -42,
+        boolean: true,
+        string: "foo".into(),
+    };
+    let json = "{\"integer\": -42, \"boolean\": true, \"string\": \"foo\"}";
+    let qo = QObject::from_json(json).unwrap();
+    let ts: test_qapi::TestStruct = from_qobject(qo).unwrap();
+    assert_eq!(ts, expected);
+    assert_eq!(to_qobject(ts).unwrap().to_json(), json);
+}
+
+#[test]
+fn test_struct_nested() {
+    let expected = test_qapi::UserDefTwo {
+        string0: "string0".into(),
+        dict1: test_qapi::UserDefTwoDict {
+            string1: "string1".into(),
+            dict2: test_qapi::UserDefTwoDictDict {
+                userdef: test_qapi::UserDefOne {
+                    integer: 42,
+                    string: "string".into(),
+                    enum1: None,
+                },
+                string: "string2".into(),
+            },
+            dict3: None,
+        },
+    };
+    let json = "{\"string0\": \"string0\", \"dict1\": {\"dict2\": {\"string\": \"string2\", \
+                \"userdef\": {\"integer\": 42, \"string\": \"string\"}}, \"string1\": \
+                \"string1\"}}";
+    let qo = QObject::from_json(json).unwrap();
+    let udt: test_qapi::UserDefTwo = from_qobject(qo).unwrap();
+    assert_eq!(udt, expected);
+    assert_eq!(to_qobject(udt).unwrap().to_json(), json);
+}
+
+#[test]
+fn test_list() {
+    let expected = [
+        test_qapi::UserDefOne {
+            integer: 42,
+            string: "string0".into(),
+            enum1: None,
+        },
+        test_qapi::UserDefOne {
+            integer: 43,
+            string: "string1".into(),
+            enum1: None,
+        },
+        test_qapi::UserDefOne {
+            integer: 44,
+            string: "string2".into(),
+            enum1: None,
+        },
+    ];
+    let json = "[{\"integer\": 42, \"string\": \"string0\"}, {\"integer\": 43, \"string\": \
+                \"string1\"}, {\"integer\": 44, \"string\": \"string2\"}]";
+    let qo = QObject::from_json(json).unwrap();
+    let ud_list: Vec<test_qapi::UserDefOne> = from_qobject(qo).unwrap();
+    assert_eq!(ud_list, expected);
+    assert_eq!(to_qobject(ud_list).unwrap().to_json(), json);
+}
+
+#[test]
+fn test_flat_union() {
+    let expected = test_qapi::UserDefFlatUnion {
+        integer: 41,
+        string: "str".into(),
+        u: test_qapi::UserDefFlatUnionVariant::Value1(test_qapi::UserDefA {
+            boolean: true,
+            a_b: None,
+        }),
+    };
+    let json = "{\"integer\": 41, \"boolean\": true, \"enum1\": \"value1\", \"string\": \"str\"}";
+    let qo = QObject::from_json(json).unwrap();
+    let ud_fu: test_qapi::UserDefFlatUnion = from_qobject(qo).unwrap();
+    assert_eq!(ud_fu, expected);
+    assert_eq!(to_qobject(ud_fu).unwrap().to_json(), json);
+}
+
+#[test]
+fn test_union_in_union() {
+    let expected = test_qapi::TestUnionInUnion {
+        u: test_qapi::TestUnionInUnionVariant::ValueA(test_qapi::TestUnionTypeA {
+            u: test_qapi::TestUnionTypeAVariant::ValueA1(test_qapi::TestUnionTypeA1 {
+                integer: 2,
+                name: "fish".into(),
+            }),
+        }),
+    };
+    let json =
+        "{\"name\": \"fish\", \"integer\": 2, \"type-a\": \"value-a1\", \"type\": \"value-a\"}";
+    let qo = QObject::from_json(json).unwrap();
+    let uu: test_qapi::TestUnionInUnion = from_qobject(qo).unwrap();
+    assert_eq!(uu, expected);
+    assert_eq!(to_qobject(expected).unwrap().to_json(), json);
+
+    let expected = test_qapi::TestUnionInUnion {
+        u: test_qapi::TestUnionInUnionVariant::ValueA(test_qapi::TestUnionTypeA {
+            u: test_qapi::TestUnionTypeAVariant::ValueA2(test_qapi::TestUnionTypeA2 {
+                integer: 1729,
+                size: 87539319,
+            }),
+        }),
+    };
+    let json =
+        "{\"integer\": 1729, \"type-a\": \"value-a2\", \"size\": 87539319, \"type\": \"value-a\"}";
+    let qo = QObject::from_json(json).unwrap();
+    let uu: test_qapi::TestUnionInUnion = from_qobject(qo).unwrap();
+    assert_eq!(uu, expected);
+    assert_eq!(to_qobject(expected).unwrap().to_json(), json);
+
+    let expected = test_qapi::TestUnionInUnion {
+        u: test_qapi::TestUnionInUnionVariant::ValueB(test_qapi::TestUnionTypeB {
+            integer: 1729,
+            onoff: true,
+        }),
+    };
+    let json = "{\"integer\": 1729, \"onoff\": true, \"type\": \"value-b\"}";
+    let qo = QObject::from_json(json).unwrap();
+    let uu: test_qapi::TestUnionInUnion = from_qobject(qo).unwrap();
+    assert_eq!(uu, expected);
+    assert_eq!(to_qobject(expected).unwrap().to_json(), json);
+}
+
+#[test]
+fn test_alternate() {
+    let expected = test_qapi::UserDefAlternate::I(42);
+    let json = "42";
+    let qo = QObject::from_json(json).unwrap();
+    let uda: test_qapi::UserDefAlternate = from_qobject(qo).unwrap();
+    assert_eq!(uda, expected);
+    assert_eq!(to_qobject(expected).unwrap().to_json(), json);
+
+    let expected = test_qapi::UserDefAlternate::E(test_qapi::EnumOne::VALUE1);
+    let json = "\"value1\"";
+    let qo = QObject::from_json(json).unwrap();
+    let uda: test_qapi::UserDefAlternate = from_qobject(qo).unwrap();
+    assert_eq!(uda, expected);
+    assert_eq!(to_qobject(expected).unwrap().to_json(), json);
+
+    let expected = test_qapi::UserDefAlternate::N(());
+    let json = "null";
+    let qo = QObject::from_json(json).unwrap();
+    let uda: test_qapi::UserDefAlternate = from_qobject(qo).unwrap();
+    assert_eq!(uda, expected);
+    assert_eq!(to_qobject(expected).unwrap().to_json(), json);
+
+    let expected = test_qapi::UserDefAlternate::Udfu(test_qapi::UserDefFlatUnion {
+        integer: 42,
+        string: "str".to_string(),
+        u: test_qapi::UserDefFlatUnionVariant::Value1(test_qapi::UserDefA {
+            boolean: true,
+            a_b: None,
+        }),
+    });
+    let json = "{\"integer\": 42, \"boolean\": true, \"enum1\": \"value1\", \"string\": \"str\"}";
+    let qo = QObject::from_json(json).unwrap();
+    let uda: test_qapi::UserDefAlternate = from_qobject(qo).unwrap();
+    assert_eq!(uda, expected);
+    assert_eq!(to_qobject(expected).unwrap().to_json(), json);
+
+    let expected = test_qapi::WrapAlternate {
+        alt: test_qapi::UserDefAlternate::I(42),
+    };
+    let json = "{\"alt\": 42}";
+    let qo = QObject::from_json(json).unwrap();
+    let uda: test_qapi::WrapAlternate = from_qobject(qo).unwrap();
+    assert_eq!(uda, expected);
+    assert_eq!(to_qobject(expected).unwrap().to_json(), json);
+
+    let expected = test_qapi::WrapAlternate {
+        alt: test_qapi::UserDefAlternate::E(test_qapi::EnumOne::VALUE1),
+    };
+    let json = "{\"alt\": \"value1\"}";
+    let qo = QObject::from_json(json).unwrap();
+    let uda: test_qapi::WrapAlternate = from_qobject(qo).unwrap();
+    assert_eq!(uda, expected);
+    assert_eq!(to_qobject(expected).unwrap().to_json(), json);
+
+    let expected = test_qapi::WrapAlternate {
+        alt: test_qapi::UserDefAlternate::Udfu(test_qapi::UserDefFlatUnion {
+            integer: 1,
+            string: "str".to_string(),
+            u: test_qapi::UserDefFlatUnionVariant::Value1(test_qapi::UserDefA {
+                boolean: true,
+                a_b: None,
+            }),
+        }),
+    };
+    let json = "{\"alt\": {\"integer\": 1, \"boolean\": true, \"enum1\": \"value1\", \"string\": \
+                \"str\"}}";
+    let qo = QObject::from_json(json).unwrap();
+    let uda: test_qapi::WrapAlternate = from_qobject(qo).unwrap();
+    assert_eq!(uda, expected);
+    assert_eq!(to_qobject(expected).unwrap().to_json(), json);
+}
+
+#[test]
+fn test_alternate_number() {
+    let expected = test_qapi::AltEnumNum::N(42.0);
+    let json = "42";
+    let qo = QObject::from_json(json).unwrap();
+    let uda: test_qapi::AltEnumNum = from_qobject(qo).unwrap();
+    assert_eq!(uda, expected);
+    assert_eq!(to_qobject(expected).unwrap().to_json(), json);
+
+    let expected = test_qapi::AltNumEnum::N(42.0);
+    let json = "42";
+    let qo = QObject::from_json(json).unwrap();
+    let uda: test_qapi::AltNumEnum = from_qobject(qo).unwrap();
+    assert_eq!(uda, expected);
+    assert_eq!(to_qobject(expected).unwrap().to_json(), json);
+
+    let expected = test_qapi::AltEnumInt::I(42);
+    let json = "42";
+    let qo = QObject::from_json(json).unwrap();
+    let uda: test_qapi::AltEnumInt = from_qobject(qo).unwrap();
+    assert_eq!(uda, expected);
+    assert_eq!(to_qobject(expected).unwrap().to_json(), json);
+
+    let expected = test_qapi::AltListInt::I(42);
+    let json = "42";
+    let qo = QObject::from_json(json).unwrap();
+    let uda: test_qapi::AltListInt = from_qobject(qo).unwrap();
+    assert_eq!(&uda, &expected);
+    assert_eq!(to_qobject(&expected).unwrap().to_json(), json);
+
+    // double
+    let json = "42.5";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<test_qapi::AltEnumBool>(qo).unwrap_err();
+
+    let expected = test_qapi::AltEnumNum::N(42.5);
+    let json = "42.5";
+    let qo = QObject::from_json(json).unwrap();
+    let uda: test_qapi::AltEnumNum = from_qobject(qo).unwrap();
+    assert_eq!(uda, expected);
+    assert_eq!(to_qobject(expected).unwrap().to_json(), json);
+
+    let expected = test_qapi::AltNumEnum::N(42.5);
+    let json = "42.5";
+    let qo = QObject::from_json(json).unwrap();
+    let uda: test_qapi::AltNumEnum = from_qobject(qo).unwrap();
+    assert_eq!(uda, expected);
+    assert_eq!(to_qobject(expected).unwrap().to_json(), json);
+
+    let json = "42.5";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<test_qapi::AltEnumInt>(qo).unwrap_err();
+}
+
+#[test]
+fn test_alternate_list() {
+    let expected = test_qapi::AltListInt::L(vec![42, 43, 44]);
+    let json = "[42, 43, 44]";
+    let qo = QObject::from_json(json).unwrap();
+    let uda: test_qapi::AltListInt = from_qobject(qo).unwrap();
+    assert_eq!(uda, expected);
+    assert_eq!(to_qobject(expected).unwrap().to_json(), json);
+}
+
+#[test]
+fn test_errors() {
+    let json = "{ 'integer': false, 'boolean': 'foo', 'string': -42 }";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<test_qapi::TestStruct>(qo).unwrap_err();
+
+    let json = "[ '1', '2', false, '3' ]";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<Vec<String>>(qo).unwrap_err();
+
+    let json = "{ 'str': 'hi' }";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<test_qapi::UserDefTwo>(qo).unwrap_err();
+
+    let json = "{}";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<test_qapi::WrapAlternate>(qo).unwrap_err();
+}
+
+#[test]
+fn test_wrong_type() {
+    let json = "[]";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<test_qapi::TestStruct>(qo).unwrap_err();
+
+    let json = "{}";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<Vec<String>>(qo).unwrap_err();
+
+    let json = "1";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<test_qapi::TestStruct>(qo).unwrap_err();
+
+    let json = "{}";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<i64>(qo).unwrap_err();
+
+    let json = "1";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<Vec<String>>(qo).unwrap_err();
+
+    let json = "[]";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<i64>(qo).unwrap_err();
+}
+
+#[test]
+fn test_fail_struct() {
+    let json = "{ 'integer': -42, 'boolean': true, 'string': 'foo', 'extra': 42 }";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<test_qapi::TestStruct>(qo).unwrap_err();
+}
+
+#[test]
+fn test_fail_struct_nested() {
+    let json = "{ 'string0': 'string0', 'dict1': { 'string1': 'string1', 'dict2': { 'userdef1': { \
+                'integer': 42, 'string': 'string', 'extra': [42, 23, {'foo':'bar'}] }, 'string2': \
+                'string2'}}}";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<test_qapi::UserDefTwo>(qo).unwrap_err();
+}
+
+#[test]
+fn test_fail_struct_in_list() {
+    let json = "[ { 'string': 'string0', 'integer': 42 }, { 'string': 'string1', 'integer': 43 }, \
+                { 'string': 'string2', 'integer': 44, 'extra': 'ggg' } ]";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<Vec<test_qapi::UserDefOne>>(qo).unwrap_err();
+}
+
+#[test]
+fn test_fail_union_flat() {
+    let json = "{ 'enum1': 'value2', 'string': 'c', 'integer': 41, 'boolean': true }";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<Vec<test_qapi::UserDefFlatUnion>>(qo).unwrap_err();
+}
+
+#[test]
+fn test_fail_union_flat_no_discrim() {
+    // test situation where discriminator field ('enum1' here) is missing
+    let json = "{ 'integer': 42, 'string': 'c', 'string1': 'd', 'string2': 'e' }";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<Vec<test_qapi::UserDefFlatUnion2>>(qo).unwrap_err();
+}
+
+#[test]
+fn test_fail_alternate() {
+    let json = "3.14";
+    let qo = QObject::from_json(json).unwrap();
+    from_qobject::<Vec<test_qapi::UserDefAlternate>>(qo).unwrap_err();
+}
+
+#[test]
+fn test_qapi() {
+    let expected = qapi::InetSocketAddress {
+        host: "host-val".to_string(),
+        port: "port-val".to_string(),
+        numeric: None,
+        to: None,
+        ipv4: None,
+        ipv6: None,
+        keep_alive: None,
+        #[cfg(HAVE_TCP_KEEPCNT)]
+        keep_alive_count: None,
+        #[cfg(HAVE_TCP_KEEPIDLE)]
+        keep_alive_idle: Some(42),
+        #[cfg(HAVE_TCP_KEEPINTVL)]
+        keep_alive_interval: None,
+        #[cfg(HAVE_IPPROTO_MPTCP)]
+        mptcp: None,
+    };
+
+    let qsa = to_qobject(&expected).unwrap();
+    let json = qsa.to_json();
+    assert_eq!(
+        json,
+        "{\"port\": \"port-val\", \"keep_alive_idle\": 42, \"host\": \"host-val\"}"
+    );
+    let sa: qapi::InetSocketAddress = from_qobject(qsa).unwrap();
+    assert_eq!(sa, expected);
+
+    let expected = qapi::SocketAddressVariant::Inet(expected);
+    let qsav = to_qobject(&expected).unwrap();
+    let json = qsav.to_json();
+    assert_eq!(
+        json,
+        "{\"port\": \"port-val\", \"keep_alive_idle\": 42, \"host\": \"host-val\", \"type\": \
+         \"inet\"}"
+    );
+    let sav: qapi::SocketAddressVariant = from_qobject(qsav).unwrap();
+    assert_eq!(sav, expected);
+
+    let expected = qapi::Qcow2BitmapInfo {
+        name: "name-val".to_string(),
+        granularity: 4096,
+        flags: vec![
+            qapi::Qcow2BitmapInfoFlags::IN_USE,
+            qapi::Qcow2BitmapInfoFlags::AUTO,
+        ],
+    };
+    let qbi = to_qobject(&expected).unwrap();
+    let json = qbi.to_json();
+    assert_eq!(
+        json,
+        "{\"flags\": [\"in-use\", \"auto\"], \"name\": \"name-val\", \"granularity\": 4096}"
+    );
+    let bi: qapi::Qcow2BitmapInfo = from_qobject(qbi).unwrap();
+    assert_eq!(bi, expected);
+}
-- 
2.51.0


