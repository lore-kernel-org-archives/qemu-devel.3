Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74297C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwkU0-0007lB-Kf; Wed, 19 Aug 2026 13:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTu-0007jh-Ss
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwkTr-0005Uy-Pp
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787162019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sC8SzC+MZjwwfsYydO7U90djsM27zi55N0MEu3u7I2w=;
 b=X6SsWsbjN/EARjoo7mrwBLDJySF9vUwPXjlENulyRdv3rUqmqfzfenvz7pxN6CtETGeILw
 PxCBfJMIlIwCOWynEbnwC7nnz0P1lNHmF1YOVIsb+ncMngNicmuEffCwH+4Jh94sOfUs3v
 Aef7lwdwryeQfsQm4P8OK4yKA+wyebc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-342-L7JW56NfP4-tDlBxmKVlIQ-1; Wed,
 19 Aug 2026 13:53:36 -0400
X-MC-Unique: L7JW56NfP4-tDlBxmKVlIQ-1
X-Mimecast-MFC-AGG-ID: L7JW56NfP4-tDlBxmKVlIQ_1787162014
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A64D1800578; Wed, 19 Aug 2026 17:53:34 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C62C07D6; Wed, 19 Aug 2026 17:53:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 14/15] hw/acpi/piix4.c: convert static variables to
 static class properties
From: marcandre.lureau@redhat.com
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 philmd@mailo.com, aurelien@aurel32.net, peter.maydell@linaro.org, 
 pbonzini@redhat.com, richard.henderson@linaro.org, berrange@redhat.com, 
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260819133816.3497033-15-mark.caveayland@nutanix.com>
References: <20260819133816.3497033-1-mark.caveayland@nutanix.com>
 <20260819133816.3497033-15-mark.caveayland@nutanix.com>
Date: Wed, 19 Aug 2026 21:52:43 +0400
Message-Id: <178716196336.2018258.16816620933120654051.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=523;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lHcDDSfJ+MOCIv7sPcYJ2sHtgjUR9RdZj1aCOp75yWA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhe1+khK15x8h2A2tqs0qDn6Eb6G5OPjS5Jlk+
 thqOFdJeMCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoXtfgAKCRDa6OEJdZac
 5QsyD/93fidyTgTTBJytxC40GPIsJE2GPxyRs5nmiiS6MIfsyHbuyaCe8HnEaYMv5KQTyRH9LV4
 CDng98d0AAh4kQYltPdGvHlcULdxfN/07VIRyhkUu8uHaHMEtbCQF2/w3AAO3rvs50Sma/4J9x3
 mCVUtJKB8qwEqKJ2VUpym4UTMxACrV2zAisfsFq3URuozRW78BBhRe8RrqqzVTt9zsBcZMWnCo3
 fvveL+US/WObTNidGwjtWeHx+TG/vOVV4FrxubkZIeMIqEts5WcPDuCjJwIkoAyO2PK0nhaLqw0
 e5PpZCiQecC8GTagqEXAwjudTgKJH/w1buHfhYCZjydQyaf7ubOPHfTR35e0aTf/6/Euma8hKq+
 sy5m/GCsG8AEFnCAaTxg+GVkS4n+r+TczbveMujj1+6aaKOx8IrR4EO9hbe79aFxHZC48X3mK3o
 hjFgXdSnS1D3+1LCJmzRC7AelJild1zob+vHD+HOjFs+ocH1yq3cnEUihdu92xtzIOrpxEDA9dC
 AMhe7YBWhjPG/U7Ru1Fwq9E7G5m2fI9oYb9fazHQseDg+xvUoUM2R+8PLrJmEEtbCIC1vDXSS2v
 kqIsE9ZdhxwBcqnWx+MkUhlca/R+Mx1ueZ/mmM8zUq8k7WQdgI/Ol+CuBDNoeBVOglwTpgThTRH
 O1giAzcuARUwl/A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On Wed, 19 Aug 2026 14:35:53 +0100, Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:
> The majority of the properties in piix4_pm_add_properties() are assigned to
> static variables and so can be converted to static class properties. Introduce
> piix4_pm_add_class_properties() to hold the static properties and soon all
> other class props after they have been converted from object props.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


