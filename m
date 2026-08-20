Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA5FC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2kt-0001Gq-5F; Thu, 20 Aug 2026 09:24:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2kf-0001FV-9I
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2kd-0003Op-W6
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787232251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xwhU3hwRKEsYC7dXNDP9npemFh0Xv0YnmJxgNr8zM8w=;
 b=fYwlQI/DnNs7hlhjcJsVGQLFIeWJ3b/vP+/XfE+l8k/g/Pm1kx21dvl0IDcPyTElQAZzKy
 qq8YVDtdnuI+/ReRvmXQX+JRgbEukHG2cEmT2HEPpPcZDIR2XeJVJtaY2Sbf36TlZAcnq9
 995z2DAOd7kOyWpMlRlvQ4IdYx2Qir8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-158-Nd9wSh0-M_-h471Hgzd8jQ-1; Thu,
 20 Aug 2026 09:24:07 -0400
X-MC-Unique: Nd9wSh0-M_-h471Hgzd8jQ-1
X-Mimecast-MFC-AGG-ID: Nd9wSh0-M_-h471Hgzd8jQ_1787232245
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B82918002F8; Thu, 20 Aug 2026 13:24:05 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40F731800347; Thu, 20 Aug 2026 13:24:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 06/13] target/riscv: Constify @iprio argument in
 riscv_cpu_pending_to_irq()
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>
In-Reply-To: <20260820104730.25462-7-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-7-philmd@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 17:22:15 +0400
Message-Id: <178723213508.2730041.1545018174811009894.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=265;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VyK4xohe3OSCoM6Erb1+RAniVARLGfWHXpRLUdsSmbA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhv/qhWfLkMgrioP10IQER+6XVwYE2/VZkSaBV
 dqI+i6dn/OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaob/6gAKCRDa6OEJdZac
 5YAbEACEx3IYgrY/w5nuUf53cgSpjQuA3TqmyiogeaanL8XDmWQ3Y9kFYOa0t7tbbVanGRpIV/a
 vHwHCEXrQJtJpbbMDRA7JfI9kBa4Hxb333kpne5gSr7KNemR+2GYvC6Vq+Dp7qP21u+UcJqHw1K
 5iB4/hlDd3EH2f7+VRS7Etoi4UINV1ioPmn9Stk6gUVsFVHss0Qmq+DFYJ/ihUgbgeQNAJGO167
 qOamqC2/UtdcPbqXy+aBqI0DGhB5egxl6+aRohyrJnns2aoWfHgmsaen4+4D+xgaH12Ml6ScLL3
 7C65BhL8e9NhWBf1FeTQUNgOiQglU6pc4zDiK2O+QS7erFhBB8HOFBh6c9gjSWmu2TNkS6b9PnG
 RUajydZihHE5lHimlYXfSHFtVtkGTQk469zt6Yft5f2kx1CGLZlYvUI3OAoprKY5ITGjNMNXFvg
 t0ak3XHW3ydYqkkH5aw3Q4g8nrOmdEOQP0KtmlZmQboE4qnASiabRBuFVVAcZevpJrjTScrxsdR
 RpMTajRhnvxLLb3p5m0lInAqnd2m7g84MV046XNC8T+UwjL49lka7U51AwWTLeMn+gaiGL7cXsi
 bNKha+faFk6NbQZVJLaGPsXBO1bAQUlarGjFCg15fRrIo4giyR2FE8Wm2iY0EThdJ4L9dQQBU3Z
 /tEcp5PJRgYxIuQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 20 Aug 2026 12:47:22 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> @iprio[] is an array only accessed read-only.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


