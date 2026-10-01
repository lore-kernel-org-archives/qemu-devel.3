Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C319CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 11:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCEol-0008Hj-9v; Thu, 01 Oct 2026 07:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEoj-0008Ha-0z
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCEof-0006MV-V7
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 07:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790853548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cut7Dm59hhGdhNnAK4vJ6+pEKoL76z0B9x5gmrcabS8=;
 b=dFSUe2x2mTi9ov+oLNGOkvM/wJsm9dxCJMEgI86zjbVF5e0fsRopHDGQ76pP9/vu3q23N0
 4FFAGfnm9fR0KmlLH+otPddiQj5ihAazDuu043PTE9Q74EG7iBjYtXDiqqzaNA6ncDiyD3
 zFyeXYQ/pwZXaMlZ8j6Wr9wSSmoFxcs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-sfBhx71dMkaW_Nu30hnvQA-1; Thu,
 01 Oct 2026 07:19:05 -0400
X-MC-Unique: sfBhx71dMkaW_Nu30hnvQA-1
X-Mimecast-MFC-AGG-ID: sfBhx71dMkaW_Nu30hnvQA_1790853542
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EFD4E19540E4; Thu,  1 Oct 2026 11:19:00 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F42118002B7; Thu,  1 Oct 2026 11:18:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/13] tests/functional: test_acpi_bits requires TCG
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, 
 Song Gao <gaosong@loongson.cn>, Ani Sinha <anisinha@redhat.com>, 
 Warner Losh <imp@bsdimp.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 John Snow <jsnow@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Cornelia Huck <cohuck@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Anders Roxell <anders.roxell@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Klaus Jensen <its@irrelevant.dk>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20260930164649.433573-2-alex.bennee@linaro.org>
References: <20260930164649.433573-1-alex.bennee@linaro.org>
 <20260930164649.433573-2-alex.bennee@linaro.org>
Date: Thu, 01 Oct 2026 15:18:51 +0400
Message-Id: <179085353192.2170790.16933925473037069882.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=378;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=svMhN2tqyV/rBu4VaN6dinJbBXXmzkdoi8DXosBuDe4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvkGdVk4i4v404xupHSS4ei75vFaWYgECSi5q3
 i1ZqZuTtlyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar5BnQAKCRDa6OEJdZac
 5eGGEACXC5Yrzf5shcusH7qYagR1aLB8bjlNMBm5Cz7UQ3WyY0geCqbx2qu5W/LwDClFzme/kNB
 HOCO3dtncSm25Rxlt9biW50SByZ8TMe78kFfSYPUQlTyR+lmn7NcYOZ7Abkr67CKUZlkbarJyxL
 TvbbMORyJllLLbv7+LFh2mq+thXbHk4lxjbGDFsvA+evBlyCH005zVo+C4Qyr94g7BHs3XRG1lT
 7zXZFfpJceO+A4sq+3JeQ6NDLeZFQGA3+4zvHp2YZ3w2pdtinlqsz5HZ7NnuQEBfJAdxNDD8KNO
 gwQvt0CcWRc4PxCOHjOSj6pcLB+9DdA98NkeV90FzJ8KEBxI9rgmPL4AfB83OieKtkjh9a6qdip
 mtA3Qw/CijYgTdJjKlsbxjOgUm13/rnaAS99iAXDdXyvbHv2ZERX86n9ufV47yste9sHHo8Lzj1
 MNOyO2Lsf6MQ3y+PhQabdySBdczzhS7yXOD9RT8Ie4EcuBHyiGJEeQq+BgC61u6M8OswO4nnyug
 hckj44yB9omr8sipHRP5+3Qpf3rInUiIIut3xyWk0SSfhU2vG5anWEx3MjwqJ46/0Fk4Se4LnLE
 yKkQVxh7DZQuwHMDlK977zvzhk0ObElvHHgPtt5YYydfeQxG8XLe9mc6OaugssYVKDIOjlhXbnH
 XJT4P94q3BLbzOg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 30 Sep 2026 17:46:37 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> Running a full thorough test suite on a KVM-only build fails due to
> acpi bits needing icount, therefor tcg. Declare the restriction so the
> test harness can skip it.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


