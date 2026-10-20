Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F7606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Nwi8lllb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ3QX-0003A4-2b; Tue, 20 Oct 2026 02:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3QE-000375-Na
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJ3QD-0007xN-FU
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 02:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792478044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C3sTu34tIaSiP1JX/PD7fh9Xuc0hmH+IQVvhcpiZujg=;
 b=Nwi8lllbnnSsyVoZZQs4lnKHl9WG2B2HL8rYiBsWR4vkilewPEep3DyEXE44xd/SLvmvlV
 d/caapT2f1dythKpakbflp+ufHoTsO8uW++AJVeh5pEZgAUyQ4mq0zhP3zgk9t4RL22W1b
 Tw6dCMim8I9YJSQ6OLi7sEBEMDZZRXo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-W4HV7lyEMKSsZoeyPUJMXQ-1; Tue,
 20 Oct 2026 06:33:59 +0000
X-MC-Unique: W4HV7lyEMKSsZoeyPUJMXQ-1
X-Mimecast-MFC-AGG-ID: W4HV7lyEMKSsZoeyPUJMXQ_1792478038
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E6A381954219; Tue, 20 Oct 2026 06:33:57 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA60D180029C; Tue, 20 Oct 2026 06:33:56 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 04/65] qapi/introspect: Don't elide types
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com, michael.roth@amd.com, 
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 kkostiuk@redhat.com, alistair.francis@wdc.com, amachhiw@linux.ibm.com
In-Reply-To: <20261019141929.1594337-5-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
 <20261019141929.1594337-5-armbru@redhat.com>
Date: Tue, 20 Oct 2026 10:33:32 +0400
Message-Id: <179247801294.2782576.16627302752030439486.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=577;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vkeZXfD3Q3Yv1VD+FGbFanY5zNsHXc+stZUv3D+a0ww=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq1wtCiI1UXXeWXYxIyAOAB5OM71LgKKWxzGIqi
 vR4FL4wPdOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatcLQgAKCRDa6OEJdZac
 5XrxD/sEhlE5cQ8aLliS5/QNxR/AePA9HJIppE4x1AuYch0DYFWilz0Rg+/WEk9wkDgFGJJYmsL
 VvnUqnYbzFx3e98mCdlloaBVdHwiUD3Jjk7JZP1iETOkQa541MgjyuIFpNdHuyOOwROe1EznwVJ
 8+BDX3mcavHt1QKohM87H/+zV/DIuIPz4QHSdmb+FkosyA8Fzi2zeYarUPlwalTFNmvbv5FiEv4
 wG1P11QBpjbuIghZb6z6XRgbo9MNiz7X5JpELtdVAaeKJVxwuJg2PWx3uHut0NaeruxA6da/eLj
 l3GMDTM6G9CDkBMviu7r51GxDtFGOFl2F+KSlYFQ/GkwAcb/f/ExZfwhCdeUdo6RGvUwCSFfKDb
 rr7ncpxkWXJ/I0kCYLTZvU2bWEN1689wzCN6tIm0AYvclAo6mNYlaOqW4IdckGHaAbdbcYHObUx
 4uH7PsoVYotG7KBOCD38Sbt/fKkFl3CHCuFkoOvz7NSTXQaDPPyCv08WNyJatmIo30zfORwXFe5
 U/EFcIGdXtr7ogCzsWGPV50CnOobEKJRaRiZq6jukXZIBqP9gqOMX7wDcoJUJRWzoCslRP1AmZY
 +Ey1eGBLEhcn8yTB0yzqGmIHCWA3koyoIRcf1Z3H1KjFMyTgM6qYYailnramg2u81elqZMaucDt
 rTXHl7cV3PxLnCA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Mon, 19 Oct 2026 16:18:28 +0200, Markus Armbruster <armbru@redhat.com> wrote:
> query-qmp-schema elides types not reachable from commands and events.
> It currently emits 1251 out of 1385 definitions, and elides 134 types.
> Whether that's worthwhile is debatable.
> 
> Marc-André Lureau would like to make QOM introspection (qom-list &
> friends) refer to QAPI types.  We additionally need types reachable
> from QOM properties.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


