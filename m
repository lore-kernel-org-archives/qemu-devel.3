Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775C606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FXV5kb4U
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJCCe-0003yT-Jf; Tue, 20 Oct 2026 11:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCCZ-0003xe-Kh
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJCCX-0000lf-Mw
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 11:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792511791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/p9IxToeVQq/ErdYBBxvJ8VSaO74Ca8sj59/F7wKZ0=;
 b=FXV5kb4UJdelF3nf1B1/BSsiFHCSwnPOJMlU45jMYAMahU1EcKiv1wOEhSXkbUBkrkWhKF
 K/zfr/Li8m7YFUaUeT8VZv5/yB36ITHkCDwZz9MZDNP6naHM/4PCU6hrZ3HaLYQXAKITGC
 REzmrWTAIlp/aDOu07ynOp8ExDrP090=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-Wn6NkGWVMbCTa26_zAPVzg-1; Tue,
 20 Oct 2026 15:56:27 +0000
X-MC-Unique: Wn6NkGWVMbCTa26_zAPVzg-1
X-Mimecast-MFC-AGG-ID: Wn6NkGWVMbCTa26_zAPVzg_1792511785
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3121E1954226; Tue, 20 Oct 2026 15:56:22 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C97C041B; Tue, 20 Oct 2026 15:56:19 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v10 01/12] chardev: add cols, rows fields
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
In-Reply-To: <20261012-console-resize-v10-1-2c3b10d829b3@gmail.com>
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
 <20261012-console-resize-v10-1-2c3b10d829b3@gmail.com>
Date: Tue, 20 Oct 2026 19:56:12 +0400
Message-Id: <179251177288.3780647.14347297879053983951.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=303;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=psT0UiiyTZPdjEArUuHtrlrkY+XOXym1oAcRcPLCIWI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq148fFg8NxFo1VA8XNo5hGwhnhpLdFOhjKtPT9
 0IFyQH3zEiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatePHwAKCRDa6OEJdZac
 5TaZD/sGVTEseZkzClKowWcf8e13CAwneukCLNhF2dJBSiJeaWsESqaV/vPbOJWzzFixb28AbKF
 t/1+DKk7N/nLac0gWa0ZPjRP8lPKcdwJTM0Fy1ssEzpzWvO5S2spSqtT/6zBWlaUwNu1D8nnCbB
 8QPCrY/wxzJRep5IwEvHpK5BVZUHkk2aqvImVOYKQlAmnuxV3LV5Tz663U5QlD6Fh91qunzEea6
 KU+IRLgnBYiP+nwRFgM8XHhStDU+tQ1Y36e8fIph07zPPJ+6zm9oUbVNIsh7nm/TkubVh3VDu/f
 P/3rw5UiQTo/IkGBv2XkHKa1rdZC/wXRwHbti+hZBQnoH/bcAYqfaTWjjJmZOwYNon6qcyjwKv1
 uF+G+gG0WGB3mMYD1b8B7Dz4+ix82W6foKb4pyP2cKd7usVNcuualggdD5qL4WtsitQNQe7jdoV
 9J/wVEQ7/w6kVGCeIiRZk2qeeQ5EssDbrgOOngxhYvBJmBRu4VS/53gWceEBrAGLnsbTME5rMOY
 VyzDx2JEiMH180WYR1IKgs9c3YlYdAplNHgdxaBqgUVNx+3MiTDVHerFOABrdVmRzgWY2c3lKFh
 FaCCsNFkcy1hP4szj5qy3ptyih3mUx1BqXdl8O8RKVQY9i9bMUnExAYkYk1Yj1dJREPWRcKlU5P
 Ekx14b7ana27dUA==
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

On Mon, 12 Oct 2026 16:05:00 +0200, Filip Hejsek <filip.hejsek@gmail.com> wrote:
> These fields should be interpreted as the size of the terminal connected
> to a given chardev.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


