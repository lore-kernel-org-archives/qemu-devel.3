Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B5DFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHibS-0005We-96; Tue, 28 Apr 2026 09:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wHdhg-0004lv-PU
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:22:00 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <physicalmtea@gmail.com>)
 id 1wHdhf-0000SA-2b
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 04:22:00 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-35fc2b18363so11749846a91.0
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 01:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777364517; x=1777969317; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5iH/8nHXuDSaocTzGMvuAMz0SIDQSlYOBoUtR+nV0VA=;
 b=enUmztD7fA8dzlJPdnlOCAxhsLPxq5U3W5IVOkvFglrXlbK/hzP42JsKNj7BEVhKoN
 wdCMWDyaA8tFjf9tGVD49LwJmW1dgJSkOMnbSzXGluep52jwAHU/fliYFUkFB7zA55PK
 HNBS/2CF4bUHwEwo44eONPuTvgsuoSO3E2hmaqh2YUfv4sdUIuaiaGeIz6Kp1ugI54Vk
 XkPixZJlpoIIKiAp87yIMtzVjNc2VM7sxXrpZ66YzomPqIqaXIAe60JMKz+Egnhcl3N7
 tNO36Xb8oJmzXrK2OCtmRzXS87Y6lhOuKX+hp947/y0hXflGSzbt6Tln7yHTUmj4pfzR
 lyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777364517; x=1777969317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5iH/8nHXuDSaocTzGMvuAMz0SIDQSlYOBoUtR+nV0VA=;
 b=Skumsmf3C6XLjOucJkdT0xh8qOiKy8tzRqER0nVc3/AWICBxoGiSOgbEySFoh47YtS
 tUKz36ynDMMHdit4KAad43+rSioijn9KPxP3i7cOa0+c1i+WEmgI1xaYKKy6tWkPf0jq
 tp21ts3/3EB2JMRSA1Xgu6hGdJjDc3L4PnP235/epT4PrQagY3kcRLZexlve6gST9sEs
 qwJGllggWVsYBJ66uH8djiVC8yI+lht8zWb85DQ23kHgEXuJ2QID6zQA/ztvgXGQfuGz
 YqdLv6Qc3cxhH/c2KcwjG8j/kYSQc5raFyF4H0rz1nnSHDsUm6OPICsIkZaX6TLgeD3a
 qZsQ==
X-Gm-Message-State: AOJu0YxF6Na2aHExgLRRHfKSB/JltHwLlOCvQWt1/Pz2pvyTKBTq/h8q
 KJ9htxDlZuHT19oqLV2sXemV3CCE7wWKp7lhIGtwvjmY6TMFo85r8TGgfsEhSW/Z
X-Gm-Gg: AeBDieuzuqQsJJGfc3tVDRFzJaOZx1wcnMEkTN8nEaIy+lxdnVVBBgO4WPACCbQ3wD6
 34ft7DcqFv0t6Smka6HQUBdGYjaYjz6o4rXZtAOXrOg99aoEuB6sTEN/CbHth2sjE7TTKlqsMHP
 TVYjW0iSqwwRSkE/8QNS6UlX0uSjy0KL5gCNVWrKNp2j8DQyhKeahAEVow7VxD/EsGRbxOwAk6U
 KgA+bTWOoLv928UMaZZ3HoHugpKMdkJ1aWq2VtaaRNSfq8z9gDOopS4SB7WJtWO+BWWLKqmwPzM
 TI2kTyngDSNWXkm0GCd3hRqVP4U+v6mnhPjABUpwBjx1C99Erm2lHU13LM0VqNOyDAt5dJJMTlo
 lgWecrRouhGTN8Fjla6xoXiuqZ30q7gTLMSZ53vRPP2biUM6YbaM6F03b1/1ayr1U2u7SXFVb8a
 OJB+QHGk63tA1Ib/VajKkK/lRVAdcjeLTbm3FfHvR34vMOpX5PmsA=
X-Received: by 2002:a17:90b:3850:b0:35a:329:73d8 with SMTP id
 98e67ed59e1d1-36491ff66cdmr2288267a91.4.1777364516774; 
 Tue, 28 Apr 2026 01:21:56 -0700 (PDT)
Received: from localhost.localdomain ([114.249.134.218])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36490fbc41bsm2065290a91.13.2026.04.28.01.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 01:21:56 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 qemu-stable@nongnu.org
Subject: Please ignore my [PATCH] 9pfs: fix deep path truncation in V9fsPath
Date: Tue, 28 Apr 2026 16:21:51 +0800
Message-Id: <20260428082151.3234483-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428074614.3169999-1-physicalmtea@gmail.com>
References: <20260428074614.3169999-1-physicalmtea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=physicalmtea@gmail.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:35:52 -0400
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

Hi,

Please ignore my [PATCH] 9pfs: fix deep path truncation in V9fsPath.

Sorry. This issue has already been submitted, and the existing GitLab
report already includes a concrete fix proposal:
https://gitlab.com/qemu-project/qemu/-/work_items/3358

Please ignore my patch, and sorry for the noise.

Thanks,
Jia Jia

