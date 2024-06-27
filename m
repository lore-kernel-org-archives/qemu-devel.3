Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A36C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 13:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMpLN-0001cr-7U; Thu, 27 Jun 2024 09:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpLI-0001af-CE
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:39:16 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMpLG-0006WH-LX
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 09:39:16 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7182a634815so4429106a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 06:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719495551; x=1720100351;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Yvl4pAdGzIA/y7zkDQtF9iZK7ptxPpuy1nIWlUirby4=;
 b=uaF7zszFj+kz80phxfb8lk1Ot7je7a0Yr3pvZry3QyHavtrSngDzdm41+eZIv469fw
 Ay8TA826kLpRlqmQP5XbY8ZxQSfuFCWcllxD1aFf9CPfwREnX04rt3BcYUekDP03HV4g
 zV2QzWwxSQRfY2cwGs8E+EvunT4q2BsKRoyHN4+jJ9YTw/N2ahjP4oTZdK+LWs/UFnQu
 rpeLmkuMFzLErtn3dPJ0qccx/gUeTVI9QLTPzfxUGkB88i82CkXVJxQnNZSlsig7+7QS
 0RN4olyKeat03LnZdY7tGSbvqlXWizIZsfq/kVl8q3ia3PBrQq3pAQ8SOvT8EeuNCdtl
 bRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719495551; x=1720100351;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yvl4pAdGzIA/y7zkDQtF9iZK7ptxPpuy1nIWlUirby4=;
 b=k+VAIeG7VYnUpJ5JohNmNhYmjC+LPmDLqbXs0dYR5hkWSGMtNV8ZBtHBQheHiT7krF
 y49bJyQoKraqtlZRSzSJTd8Hb/psqQbY3hq6t02meSmUcb/loFBDVczgPjAjweflzL2H
 M+YtOi+YEtmqIjAS12yBNMN/zEk3VZHHgrG5tl/zRcBDAofhVCgtQixEYNHNhDjY9137
 FNVW/4lWlF2rMRYpK6LgjW+BRKPBFpootLrHWfxH+j1NHBLatPqZPk+rAJvd4e+QSO5O
 ww+LNVWJD/GFog3bquWfoSP/drF8G+z5rtTTFIJP0b8RdKyn8YzPW1z096qHfMDqeiwP
 mEPA==
X-Gm-Message-State: AOJu0Yy5Cy2rF5WGhSBWB6QdhDnIXzIsYzO3a4rs3IKtNB+Ih+QizhA1
 5OOxRJYotnShMPvVfWK2r1S2bOTcyIGBGNYMeTH5peJJb7ev29UIWpQS1PLRAzc=
X-Google-Smtp-Source: AGHT+IFlBGhq8j7ZQMV5qMOOdFsofTqP+NF+lT2o/+u4EH2nCOdF15FzOTWiA/9TuXR60cGyfzX9NA==
X-Received: by 2002:a05:6a20:12c3:b0:1be:cbe9:f765 with SMTP id
 adf61e73a8af0-1becbe9f89amr3175993637.18.1719495551639; 
 Thu, 27 Jun 2024 06:39:11 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1faac9a73fcsm13434485ad.252.2024.06.27.06.39.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 06:39:11 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 27 Jun 2024 22:37:53 +0900
Subject: [PATCH v2 10/15] tests/qtest: Use qtest_add_data_func_full()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-san-v2-10-750bb0946dbd@daynix.com>
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
In-Reply-To: <20240627-san-v2-0-750bb0946dbd@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

A test function may not be executed depending on the test command line
so it is wrong to free data with a test function. Use
qtest_add_data_func_full() to register a function to free data.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/qtest/device-introspect-test.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
index 5b0ffe43f5f4..587da59623dc 100644
--- a/tests/qtest/device-introspect-test.c
+++ b/tests/qtest/device-introspect-test.c
@@ -266,7 +266,6 @@ static void test_device_intro_concrete(const void *args)
 
     qobject_unref(types);
     qtest_quit(qts);
-    g_free((void *)args);
 }
 
 static void test_abstract_interfaces(void)
@@ -310,12 +309,12 @@ static void add_machine_test_case(const char *mname)
 
     path = g_strdup_printf("device/introspect/concrete/defaults/%s", mname);
     args = g_strdup_printf("-M %s", mname);
-    qtest_add_data_func(path, args, test_device_intro_concrete);
+    qtest_add_data_func_full(path, args, test_device_intro_concrete, g_free);
     g_free(path);
 
     path = g_strdup_printf("device/introspect/concrete/nodefaults/%s", mname);
     args = g_strdup_printf("-nodefaults -M %s", mname);
-    qtest_add_data_func(path, args, test_device_intro_concrete);
+    qtest_add_data_func_full(path, args, test_device_intro_concrete, g_free);
     g_free(path);
 }
 
@@ -330,7 +329,7 @@ int main(int argc, char **argv)
     qtest_add_func("device/introspect/abstract-interfaces", test_abstract_interfaces);
     if (g_test_quick()) {
         qtest_add_data_func("device/introspect/concrete/defaults/none",
-                            g_strdup(common_args), test_device_intro_concrete);
+                            common_args, test_device_intro_concrete);
     } else {
         qtest_cb_for_every_machine(add_machine_test_case, true);
     }

-- 
2.45.2


