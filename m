Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11305C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9b9-0000ea-Pw; Wed, 12 Aug 2026 10:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9az-0000Yp-78
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wu9av-00037q-TO
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 10:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786543573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLhHanUoWaVv2v1iK2cHoJyVRz5LcbVeRuIisVTU1Wg=;
 b=MMhBAnlOgSbPbD5MwSLnFUM0nszi/58eDvoJ62cO38HUuTrih3o6KQutV1N5JdXYBKnhRZ
 0ALFapWv5ZBQXzAN0XjrXvb6/fcuX6XJHHL219Gv+8MdYe83bVbEiK7QgOB/6NTFtYM+Zb
 sBSDaL26d3OsebkkdJf+uPa3C595ysE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-28-0v2Fr2iOP7OkS0AqRm7i9A-1; Wed,
 12 Aug 2026 10:06:07 -0400
X-MC-Unique: 0v2Fr2iOP7OkS0AqRm7i9A-1
X-Mimecast-MFC-AGG-ID: 0v2Fr2iOP7OkS0AqRm7i9A_1786543565
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8B571954B17; Wed, 12 Aug 2026 14:06:04 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B6AA423; Wed, 12 Aug 2026 14:06:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 04/16] qapi/qmp-registry: Remove unnecessary
 'monitor/monitor.h' header
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Michael Roth <michael.roth@amd.com>
In-Reply-To: <20260812131147.83188-5-philmd@oss.qualcomm.com>
References: <20260812131147.83188-1-philmd@oss.qualcomm.com>
 <20260812131147.83188-5-philmd@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 18:05:43 +0400
Message-Id: <178654354336.2071945.8170936159564261872.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=222;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=56EksiVg8FoS0BiJI4Za4tVk2wRUWDoALtcftrjl/Hk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfH26ia2JkjFw3KG0cDnXGjbRSMwMiZxT0I6Z/
 QLwESBFa4GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanx9ugAKCRDa6OEJdZac
 5QRmD/4yf2n7KPR/a1gIUWJkkI9+4/2DMoPaKI8r5J228Ne6cZorI2LZbSkL47MZmO3Xw8t5kUZ
 wRxsWDbXYaM1Dozi+ulv3qCX8tjSA1jvUectazHxKuhFtirAUQQlYrN/+lgjeP4Wha29kBnPBGV
 IBz+lJU4ZIOD3zc4GvZ3xXpJ8np5UKTlUYLngNBM0s4vAYIWTJHjOoWEcWfENmZMajSYncr5LhY
 /sM3hKqhgP4QYUbCPXbH0TnA09XprZ+vm+nB6wxNDW7OrEaRYpS94G4GEDnwZcNonYIf62KPlMs
 Y9nnWuC0XobStjqrrv/UgolzjGbGsURW7lpxoRVJy0LzdKyUF+shC6BiNb79mBcHxGvksODAGiq
 3mD3EM1xRWji7asbtHndWcEhXcxw43xIT66H0myPp335AOaoJlvUWiUYuko4IdYbbG5W6tdp5b7
 4duPE6vZuc23VsZ30vRShcTCx8zWFdBNHmXnm0XIPzF+DgF3BiHA7QrVpi3fPEkXBpuEtcetcKF
 oJ5XBVh3Zrt3xWapObsZ6CkC92KZWUyfPcvz03clDwOLJHkzv86DeXEoS7m6hN+tGfh3wdHwcHS
 zPrWmT0B8AfU0bjLYcmkPiccxDPWaSZDaGefNSIC5xObwoFldLxOqt24kFHw3+RAw/aUcLC9Atq
 Jxw3Xg1nWiDXlyw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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

On Wed, 12 Aug 2026 15:11:35 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> 


Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


