Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C929606A332
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H1iExDn7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCD0-00041z-0R; Tue, 20 Oct 2026 11:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCCw-00041h-Dq
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCCv-0000pG-6T
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792511816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V0mtgIwy7RrMfJniGVObEl/D2TuyuPyDJQ1h0MtVOmY=;
 b=H1iExDn7pmWOeyEJajyR1WIfonmXfLX/G24RhyM1bnAVnYwt0E3nf4AjG1nC8pWrwsbrlZ
 A1riXmLlnrOClFiVOl9B7/TE6JTZvlUIEZboFseNtbDvMthKLTioQFidP+iyrVjBEbhd1J
 OdZYegnGUWLgFJ99y94q6qbNbqer7+Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-y9e3YcHwMo2diwWgVnqR_A-1; Tue,
 20 Oct 2026 11:56:52 -0400
X-MC-Unique: y9e3YcHwMo2diwWgVnqR_A-1
X-Mimecast-MFC-AGG-ID: y9e3YcHwMo2diwWgVnqR_A_1792511810
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 906E71953963; Tue, 20 Oct 2026 15:56:50 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44D50418; Tue, 20 Oct 2026 15:56:47 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 08/12] ui/console-vc: forward text console size to
 vc chardev
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
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261012-console-resize-v10-8-2c3b10d829b3@gmail.com>
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
 <20261012-console-resize-v10-8-2c3b10d829b3@gmail.com>
Date: Tue, 20 Oct 2026 19:56:12 +0400
Message-Id: <179251177298.3780647.5244244031011590162.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=653;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2IpKweTIDuthJDDV7ho9qyASt15Z0lBGkkOUi67vsx4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq148gBm1bvIX0McZBYAIluPvWooVtDg88G6ZMj
 Ra3YoBt51eJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatePIAAKCRDa6OEJdZac
 5SYxD/9TZy7yDAgjkpnkRBxmZDXg9mW1Jtgkp9+DZsADlZJkC/MB/R8DAYBwL4U1w7chUApyld6
 oBfyWPRa8sMTis3IegJbRifvt5So73DYGZ0BKqvuyMifn3ebSfXkahen/7300IH0NHKD1VBxsNl
 qdVNKLcc7ZfKsb+5nBetuLEhJi8JC+JVKxgKZH5V5YomfnX3cfB8agcywBRz+NYSd/1dCQrdll1
 LkVIrj7IgDQ/duCV7LCdYcJkiov5OxmH5eJUjDeXj7MRjrpLhV29adF9la3+lsc0FmHP5GBbo2x
 3eIYQIUA0r7VMRkFm8DVpVnEMjTkjJuTqWCO7RrBvYyLvj6LsCpd4KqbudxIfYAMx+jLGZGHJE3
 oCs1bgRfiJQ5OCO2HRdnfwUAczqKh473jG6pxRJ23AFRYLK2NoVQgSulwdCmlMZTBmkxgcQCmqn
 ZWCXuEOwiHrdcM90OD4OcvokZFFCJEK7Kadc/bZSXfH2sAiU+6NwBzr+iuxcX1ftOH7zW5jTdHC
 AEBaeJhSVdM0d+E4PwCAPF2lmIcmx2qc0xqZKXjbBtm5GJtSF6C+0ioBxQ8SGgUorVT0/WO6QkP
 wR/zEmIbPGPuTpgCFRHov1DRDxOde4hMooufSXUB+kHPO/LhS8RkkNaZp64MBlflGyEslo+uYIp
 5e5UNM6zv4YLn5A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 12 Oct 2026 16:05:07 +0200, Filip Hejsek <filip.hejsek@gmail.com> wrote:
> Update the vc chardev size when initializing the console and after
> changing the surface image.
> 
> NOTE: There seems to be a bug in the code where the dpy_text_resize
>       callback is not called when the size changes due to changing the
>       surface image. (Though it doesn't cause any problem in practice
>       because the callback is only used by ui/ncurses for fixed
>       consoles, whose size never changes.)
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


