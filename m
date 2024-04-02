Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AEBCD1296
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 13:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rre0w-0006Ml-KG; Tue, 02 Apr 2024 09:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rre0s-00063c-Fi
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:17:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rre0q-0006aq-5C
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 09:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712063834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+vqxdTO2VKLgQ7KsbDKTOHrw/FHBZ8UlPh38mHZ3HDs=;
 b=PYxjDVcEjvbtnzsfOkKekwMfY+6+qT21IbP4O0XeWaYIGxhwSMA/zmr6xTWlyEi1EN2r2z
 +FYmzyt2OQp72zouhOJwwy6iH2ETwQTpY3y6wNZ6+UfM//JsW0ZCB0IYbzCVWtiqRypiEW
 sdNaJHbAGJH2nJyJOK9gg6qQzxQ6Xnk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-OdraOvlEP-endRO59Sbalg-1; Tue, 02 Apr 2024 09:17:13 -0400
X-MC-Unique: OdraOvlEP-endRO59Sbalg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33ec4fb1a83so1966754f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 06:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712063830; x=1712668630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+vqxdTO2VKLgQ7KsbDKTOHrw/FHBZ8UlPh38mHZ3HDs=;
 b=AwchYblmz8Hftyd5uAOm2vB+TkVW/K/UsqusH38FOkXY1MFfv1Xo6nD6CW9Ws+6QdE
 bGyeXbZCalPGL9gsmFmoa5IlCJ84Nqkj8Cr20HPp9TIYswsb5KADDRQS7u4c3AdONxbk
 83fqgtkroAJMDlVcBaidFZgWWcsY4SBijMS9MK4h0v2rBVVaHf7iSrJ8MPzQeI6BEwlu
 PjortqEB5UYg6Gv3O1Nez3X3tDVkffYyX62nltGOP3rY7vbzo7bNYlrHAnhxSYi+RDVP
 81Jz6eiFlXZTdbTvWjvhFOsISfJ6pela3ion9Tpj3qZ6EzEy0UO5F6vRpb5sGSCq3Efv
 luKA==
X-Gm-Message-State: AOJu0YwbPs/eTkNqqX7gPTr/lXtx722KKR3SGprOnogIru6xnwpzMC12
 UW+SRTJ7kav5+LBjacpfK2NS3JnoMU5tvTK4b1k1V3sI3odI2VUxG7cwaGY4B9Q1cz+FqJsPIx9
 NtMpM2h0QZ7jdMYjRDjv4ZGTNDOXWSyURSv1qnVfX8M3rT4RKngpcPD+DE0zIvJh1iLZ4w0bsA1
 3/ux/JXQlXkUKTV9nL9oDncHmlJYnRfeY3VfKp
X-Received: by 2002:a5d:6e65:0:b0:343:419d:ba87 with SMTP id
 j37-20020a5d6e65000000b00343419dba87mr5309563wrz.13.1712063830625; 
 Tue, 02 Apr 2024 06:17:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL2BNwqs9WBKhoLzd9fhCtkNKamPiJwEGHUc4mlGviRc24lnCSEzpNICt8cvlqDm2pYjwL9Q==
X-Received: by 2002:a5d:6e65:0:b0:343:419d:ba87 with SMTP id
 j37-20020a5d6e65000000b00343419dba87mr5309549wrz.13.1712063830376; 
 Tue, 02 Apr 2024 06:17:10 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a5d64c1000000b00341b5cf0527sm14275609wri.11.2024.04.02.06.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 06:17:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Chuhong Yuan <hslester96@gmail.com>
Subject: [PULL 6/7] lsi53c895a: detect invalid Block Move instruction
Date: Tue,  2 Apr 2024 15:16:48 +0200
Message-ID: <20240402131649.23225-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402131649.23225-1-pbonzini@redhat.com>
References: <20240402131649.23225-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The spec for the lsi53c895a says: "If the instruction is a Block Move
and a value of 0x000000 is loaded into the DBC register, an illegal
instruction interrupt occurs if the LSI53C895A is not in target mode,
Command phase".

Because QEMU only operates in initiator mode, generate the interrupt
unconditionally if the low 24 bits are 0x000000.

Reported-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/lsi53c895a.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index eb9828dd5ef..1e18d88983b 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -1205,6 +1205,15 @@ again:
             break;
         }
         s->dbc = insn & 0xffffff;
+        if (!s->dbc) {
+            /*
+             * If the instruction is a Block Move and a value of 0x000000 is
+             * loaded into the DBC register, an illegal instruction interrupt
+             * occurs if the LSI53C895A is not in target mode, Command phase.
+             */
+            lsi_script_dma_interrupt(s, LSI_DSTAT_IID);
+            break;
+        }
         s->rbc = s->dbc;
         /* ??? Set ESA.  */
         s->ia = s->dsp - 8;
-- 
2.44.0


