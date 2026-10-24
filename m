Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC0A606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PSYtCano
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKbg3-0006Vh-Gd; Sat, 24 Oct 2026 09:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xKbff-0006Nn-Lv
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:20:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xKbfe-0000l2-9z
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 09:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792848025;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gbGWsZ6giJOaFJ0BYUUGdgoQndYDFUhU/C1XnkP/IQk=;
 b=PSYtCanotHAd/IkkoshQhQvuGthzgZCDpYWLZS4zuqFP+syEnEbPDIPxzUimmPAjy/T0h8
 mxDhUvpeKIF3QPh9F1VzNnWCELtDP9AfHjj6dre9qFDug4thN1uHaFPfjKLxyUOI4oAmEH
 kjOdJgnnG7F/v7H2f7uYPhprZNwEuPs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-5N5F7DQwOdeJg-FZ-PW4iQ-1; Sat,
 24 Oct 2026 09:20:14 -0400
X-MC-Unique: 5N5F7DQwOdeJg-FZ-PW4iQ-1
X-Mimecast-MFC-AGG-ID: 5N5F7DQwOdeJg-FZ-PW4iQ_1792848011
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 926FF1955F0D; Sat, 24 Oct 2026 13:20:10 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A28118002B1; Sat, 24 Oct 2026 13:20:07 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 11/19] tests/guest-debug: add --symbols option to
 run-test
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Peter Xu <peterx@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Kyle Evans <kevans@freebsd.org>, Keith Busch <kbusch@kernel.org>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>, 
 Anders Roxell <anders.roxell@linaro.org>, qemu-arm@nongnu.org, 
 Song Gao <gaosong@loongson.cn>, Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Brad Smith <brad@comstyle.com>, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Klaus Jensen <its@irrelevant.dk>, 
 John Snow <jsnow@redhat.com>
In-Reply-To: <20261019192704.3220373-12-alex.bennee@linaro.org>
References: <20261019192704.3220373-1-alex.bennee@linaro.org>
 <20261019192704.3220373-12-alex.bennee@linaro.org>
Date: Sat, 24 Oct 2026 17:19:42 +0400
Message-Id: <179284798277.974117.14902530337150441422.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=548;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Fn2K6vH/+wlt3zifr4W2HuzDxiWy0qLFC+6FoZVdx78=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq3LBxNl1oG1ebLv7eRxkCOF7ieKMFCbZaSqvz1
 45LIG4UDLqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatywcQAKCRDa6OEJdZac
 5Z0cD/9i4nbKSkpbHZ2ApZrMQlvFu11J8N/txX1PXsu+NRTsWiPm0Xx0H/CWAxo47Ie5YAVLkA2
 Kh5WJKWSW6X+FCD39UrYwGjM5Sr3V4vWz/ImznSw63o+B3CPqDDkG/UnX5vsLnqe80bFoji9IP/
 +/Jia2dCH6z8Yusr2M3ePEx/3CKhvu1QddXp56SBmNCAJLhKX0oH+bOmjfAV06vi4W+RdoAZtEF
 a5rRXvJZ8s10HG/AHFeVzR/f8qbsUNjhfvrKbodHla1CC0YuP+yil8TdWI0GZCQq/3YOL44WLRj
 YFsfFXZFWgcIJK5LQxNS+owUhXuc6Ce/oAYOGNR4Twpv5598CoiL/6lRqittsXr3FZNkjK4vGHK
 sHduSGftCAkXL/7lSAqUrsLy4MbFJ09hi3v1ikycLeEXC3MleoIGK86Z8TWQVPxi9oPqMIdJ6NW
 FuaNQSlUCRCyh2UH4l7dYUWjqUwR4dOZ7YpRZqO4X51tn+3keCZlx3wXz+m0IZM0kH6Lh2XtOm7
 QMyF5e97dklFyOMLP+LP+VBpcgaUVw8KBhWJ+XM6vYMXlDjxf4VSue0NkCZuOfGAwPHIdCek1FR
 I673cqLp31fUsbKGOPbQxfJ+Ty1EjKQ451JdBp9C63R1dB44Z/6Xvlp2RbYqPDnJk45s7dGniKl
 oLhJJPXQiB3fnQw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 19 Oct 2026 20:26:56 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> Sometimes the debug symbols are not in the kernel binary image but in
> a separate elf blob. Provide --symbols to facilitate using them.
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Message-ID: <20260930164649.433573-12-alex.bennee@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


