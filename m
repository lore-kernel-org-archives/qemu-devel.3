Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85A8C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 06:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shNYf-0002wI-TS; Fri, 23 Aug 2024 02:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNYc-0002hI-H9
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:13:58 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNYZ-0003A9-MJ
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:13:58 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6b47ff8a59aso13788887b3.2
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 23:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724393634; x=1724998434;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZgDoeEKExDSUUkKhA562XJclNi5ZhOHvZQVGrzBwI+A=;
 b=0CjR7ZFUMrdwM+EQfvY1BmqX2JlVw3e6JNbgP6/gMuwvRsYzHEZgUYJMyxslQ+JlQ7
 FV0WcoqX7cyHQzVCFSiUDywnAU+hV7ozmsBTB6ET/ZgR+AOcpHowW1YzD6/pUIJBQJYT
 CO3n2m3/N0gokYF4HyTFex1erXhvmKQ/DQq3ASIMyvw2BJLxYYp7CApj5kWih/jVCZeg
 vV0+Bpq2KHBRm1I/2q0aI5l4e1D1V/2mvr/0Zj7Zu5P8iY9FRlBF1TQl3BzZWREoOWHp
 WT4s+2uWZzfUCkDDeoGQa36xIjcpQfXziwk0f33sEHZcShkWeqtczxHVhAK2dT1iSeuj
 MhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724393634; x=1724998434;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZgDoeEKExDSUUkKhA562XJclNi5ZhOHvZQVGrzBwI+A=;
 b=TTj5u9m3dsUDp8+IDlCu3Nj19sh5atrMmWeo9leOD9CYJ35BxUQTot8CLxE8msmc91
 WvwkvRO0jNMDjFdHLL/hnzrwfVeOK1RrIaX4+l+f6V1eBdyeFZHb+W28KyJ/ocIrgy3F
 g5YSALct36tZc9GLWPLhM6IHohURisVMUlVkVX1VfBIAC/ZasM+kjFKG5pWriCvz36Qn
 mlFrfFyvXjb8qd1tecNlQYH4dT9/znC095Dd1FpeMx1t7Tjbs7FTOxSEofkuxohCqQeM
 BxuoxMiO0iKPrp+Mgkoy87z/wF0a0sxlyZzgI8GeqvnBpSN1HX+0h+2tzZYZZ23iAtDQ
 vTEw==
X-Gm-Message-State: AOJu0YwnWgnC703KuXDJGabT7Xlp7k2+ucOItJXgWlM7tSU5T6Nj0IGQ
 2DGMz/45pqObLegSgfdR2VF9uvs+0gK/j9SyLVYl0vu/7jgO3Up6q+mdKxmPusY=
X-Google-Smtp-Source: AGHT+IGuj1gFQTuDEsrNan7a7imNn/Sl/n8Bp2+X8RKJ6f6S0gWckt8yw2CT52Rt7ce2oK1y4+9S6Q==
X-Received: by 2002:a05:690c:18:b0:64a:d5fd:f19f with SMTP id
 00721157ae682-6c625a4ca3bmr14298007b3.18.1724393634631; 
 Thu, 22 Aug 2024 23:13:54 -0700 (PDT)
Received: from localhost ([157.82.207.23]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-714342316e8sm2406058b3a.16.2024.08.22.23.13.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 23:13:54 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 23 Aug 2024 15:13:10 +0900
Subject: [PATCH v4 5/7] memory: Clarify owner must not call memory_region_ref()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-san-v4-5-a24c6dfa4ceb@daynix.com>
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
In-Reply-To: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
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
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::112d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/exec/memory.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index d79415a3b159..6698e9d05eab 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -1220,6 +1220,7 @@ void memory_region_init(MemoryRegion *mr,
  * memory_region_ref: Add a reference to a memory region
  *
  * This function adds a reference to the owner if present.
+ * The owner must not call this function as it results in a circular reference.
  * See docs/devel/memory.rst to know about owner.
  *
  * @mr: the #MemoryRegion

-- 
2.46.0


