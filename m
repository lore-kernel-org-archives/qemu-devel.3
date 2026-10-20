Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C5606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ja03YprT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCCd-0003yL-Sl; Tue, 20 Oct 2026 11:56:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCCZ-0003xf-D1
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCCX-0000lj-HY
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792511792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DI+IGXUlSOfsuUWTz77nUOF7kHV6AizYztEMEPTD+dk=;
 b=Ja03YprTzZOW7p5UvZNCAtRPbvV4Bb0m+xzFW1YUzdLcGSdQPgDWaAj6jtml8WxI+VbL+m
 eyWzYbG+UmDPXJQEmlHjrlXXdkofyqXqLBPiojv3XmiQsnXWHf/enwSci789Y3q5qtd7Yd
 g8ePHUDwAJEcrKJ/K4C53WTL7pE47Kc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-XfOBNZk4N-eV1aakzKMuVQ-1; Tue,
 20 Oct 2026 15:56:29 +0000
X-MC-Unique: XfOBNZk4N-eV1aakzKMuVQ-1
X-Mimecast-MFC-AGG-ID: XfOBNZk4N-eV1aakzKMuVQ_1792511787
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06C6E1800A34; Tue, 20 Oct 2026 15:56:27 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0919741B; Tue, 20 Oct 2026 15:56:24 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 02/12] chardev: add CHR_EVENT_RESIZE
From: marcandre.lureau@redhat.com
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
In-Reply-To: <20261012-console-resize-v10-2-2c3b10d829b3@gmail.com>
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
 <20261012-console-resize-v10-2-2c3b10d829b3@gmail.com>
Date: Tue, 20 Oct 2026 19:56:12 +0400
Message-Id: <179251177291.3780647.16550804828463231536.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=342;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AYS4EVC5hhzsCqzCncTGX9XU+vg+gBNknsM6kRL99Ao=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq148g3sQpL1GVbc3NY7UE8EZ1YpBplN5Fski5p
 h+/uUSafHuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatePIAAKCRDa6OEJdZac
 5fU2D/9Jv0YGKYECPsyOkD8uCQrLnZGrSLJwte29797a9mCdAs5TH1gmRHW5+B/qcss3j/T/fZs
 BGUNpkORgn5eoFRkzzzxg1A4MTKLv0swx/lXRIeU4NevmJxHYMgwJ9mnLP7B0hFFOMZcAVjiZv2
 V4bN80u//k+F+szqj7m88Ka5Vo391J7bdy2WKjIy96mpcQXgesoqF95jxVqVgjVZshYudhY7OmU
 2VKx8Jkzo19PnA2rTHPYIdkmBRtUMZBdYxpQmIq4wgFOuMPUWy3gHQerzgRWan/1VVDWeOSdQXl
 s3VZJIAojq7XwLiFNHnbLECFVCNcFebQI6bzKU+2JuzpwmnjquefO7lxTuRjsKV/K/2o9XANbO7
 GuKRlkHmRmm6ys1EAh4kZeoWVHcc5DPJERxSOQU4zh4+u/Z94VTru3GbwVDBWy1d9fqwhgGso0z
 MTXE2SLMwupuruMBptqsePre+tNZeZ3pJ0V9kgApk9kB/NMDk7jB+BBIg4oWOTve5+mDa1894K3
 2rraJdtuvZ5zdUCZI8lIvzwoDPHrG2HO0LR/vP0wX4VW2KPNnx7EJwok2gpYDE6nxZa3E0lNxAZ
 1GH6DfteH7ueADZZ3NocGuOO2gSoYO8a050cO30+yrnxgnY5hNQZpdj4yhFyUS7sioi0iWLH64w
 70CSTVeQM4EfDqg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 16:05:01 +0200, Filip Hejsek <filip.hejsek@gmail.com> wrote:
> Add a new chardev event, CHR_EVENT_RESIZE, which a backend should
> trigger if it detects the size of the connected terminal changed.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


