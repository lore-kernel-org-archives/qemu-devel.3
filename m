Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7024FC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 12:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx20h-00068Z-VF; Thu, 20 Aug 2026 08:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx20g-00067b-Uk
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:36:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx20e-0006XU-BM
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 08:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787229399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DbeAM1pVIxyh+Qg0Tpgg51OmAKBT6CI3q55TN5MmgJc=;
 b=Drb39l1mgmc/1Nr8TQXBkMV6AfDZLX4YUBKP5kaiKpX8Qs+w+dMipPbRDPyn3P7LYbanfw
 q2ZQrQDdFk1cOKigN5mDmgywuTLmmVJuZR3cHe9bG91CUcXDqPVGb3qOdrUNNAyh1dKpnb
 yofSf0x6hghpWmpvwhoxEpr0XRuEBI8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-492-bhVsRVDcMLS-HE1vruv0mA-1; Thu,
 20 Aug 2026 08:36:38 -0400
X-MC-Unique: bhVsRVDcMLS-HE1vruv0mA-1
X-Mimecast-MFC-AGG-ID: bhVsRVDcMLS-HE1vruv0mA_1787229396
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D86DC1800366; Thu, 20 Aug 2026 12:36:35 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 43095423; Thu, 20 Aug 2026 12:36:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 02/13] target/i386: Constify CPU*State for
 cpu_*_interrupt() getters
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
In-Reply-To: <20260820104730.25462-3-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-3-philmd@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 16:36:07 +0400
Message-Id: <178722936783.2678991.15248783006109879102.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=393;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=XrUQAizlyM68p7wLXpRFvLVUmo6BnJv7VNVnEH5/xrE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhvS70Ng61OwE6FSLHznIBhsHWX2jgEuUnnVA2
 k4keO3EBaaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaob0uwAKCRDa6OEJdZac
 5c41EACcpmCs5XilufI3LNt6KkY2RF5YthmoOZfMO+rDT1G8jP5s/EdmJCcMxhIyOjiUXW1nRYW
 kn1g376C8uiRHjk2g3im6atkYcDMI25h1bdzwstTs2e+K/D+iCYEn/fhRgaR6GYWNV9yIKcjMn4
 L2YOxVaKiwg/EmkX8hYoQsTHBhYltpGsJLBsb5TN15zazUFkRSawvFq/qIYES/xn4ZT2VBeOEJ4
 bKocXa3KE1REHJmYvdkz9FpmLCIDWy46NNBrhr4v2LIjZJ5i8zg1oWU7SaZDo4ssjmOB1MQOXEc
 aZvTN0wdxcj3uQkqxWM9FTJYqp3H2NaI3fhrXWr3re2RoYnzNW9RoyRqpZC5rpHXRzGoJznhd3r
 JgXGJyATRAKyyArBU5aNDTIMokFwpiRU0UILO/zIjKU//lisOiDbpvDuS0LkaDgrTbhMOJV+37V
 nvuTmjsV3r0ts+9oaZxBsiowCezTuBhB34hnANAxVU+nbcQqFs3+fsDjw57WUQbA62CyvuIOjzu
 1a4JOpkx4SEzRq1lBE6rf7jEDaRl1h/HGYB6fKSbj0aQ5b4nBdVoaflCHpULVVF64yWrY5ScfU3
 omJx6yquQV977WXoJs0J946JjJbZtAUzMkCZxsW8Mno20UfBE9gXLalSqssOD+/xeraYywrtLQR
 yc+sDezwC9YeiJA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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

On Thu, 20 Aug 2026 12:47:18 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> x86_cpu_pending_interrupt() and x86_cpu_interrupts_enabled()
> only read CPU state without modification, add the const
> qualifiers to CPUState and CPUX86State parameters.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


