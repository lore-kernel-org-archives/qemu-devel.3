Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF21CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 09:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDeYG-0002Aq-GT; Mon, 05 Oct 2026 05:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDeY3-0001xy-AF
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 04:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDeY1-0002an-Qb
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 04:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791190788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iONKJHha+jEfQvr2HrggmG6ASEPlA3+RKa+4Zyf/L7k=;
 b=cG3JnWYvLxq7qyhOSQNtAo8IoVKcmw2aOYVZdC5bijbEG0LcLy/I5jSHBg8hUbOXbOvRHG
 NcQYgk7qoOxxdMSxvXKghhXuxlzPNl6FTV/0P2gZflJwd/nmGn2In4c428JHsvZbl/awkc
 seh/NS/gbnyxxUr/icA3TcXPRZOuo+U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-32ydjOdBO5KZ6Bhg_7W2gA-1; Mon,
 05 Oct 2026 04:59:43 -0400
X-MC-Unique: 32ydjOdBO5KZ6Bhg_7W2gA-1
X-Mimecast-MFC-AGG-ID: 32ydjOdBO5KZ6Bhg_7W2gA_1791190781
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 639151800666; Mon,  5 Oct 2026 08:59:41 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93AD630000E4; Mon,  5 Oct 2026 08:59:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 4/8] hw/usb/redirect-server: Announce the exported
 device
From: marcandre.lureau@redhat.com
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: clg@kaod.org, Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, 
 "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 Troy Lee <troy_lee@aspeedtech.com>
In-Reply-To: <20261005032022.3980903-5-jamin_lin@aspeedtech.com>
References: <20261005032022.3980903-1-jamin_lin@aspeedtech.com>
 <20261005032022.3980903-5-jamin_lin@aspeedtech.com>
Date: Mon, 05 Oct 2026 12:59:18 +0400
Message-Id: <179119075847.699310.8612404871730252132.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=678;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vzFv3aJXmquhdGjsoM9uYxteDU6pYM9T/YAzSDjy+po=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqw2bqlMQNv5RMNxwB3viF9kU7Yx23l8c3SNJNU
 9pSKbJwVn6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasNm6gAKCRDa6OEJdZac
 5dkwEACaQP0iKECIq8aHP9o8l+CoxQLazbKjGT+JlsLGhVRNlO23Pm4e8E50jFExrxJgt5N2Ij3
 1YPMGnFfAlMQKWPmr3AfzbyeiC7kafW4CXO/MnMheEYrhUag3Hq6XZoeHxozxOyogGGbYgvu3Eo
 UhQ8lr6ICGde9rQw5Uv75nwXhOMiYOlkqrrzkEjX03QLhY5wIDcK8tM2lGhkl9UnJcB8l+88XY4
 JPX4MQY7O8qdXUxREI830w4AnQ4qd7BHb3uZ29KcL6ZbfG0QV7MNboGd659g+xhMsycL9HaSCaH
 fQK+hQp+VPG0pcco/WoFLsNTd2U76Ix9powJbgSuW4gB3OHrzgvGjA4PqNOebNLdtqKHqJjSSC/
 EHzW02edCLOD+BCTnlqr681YewimJQdNH5aZ83wPCPxl2jGjKhVYWOY+hfWClBHHUQJgbXm/u2A
 pwB0RMntFg+P1IyYEyElz3H6LJi75MAu1WlTvBPdzREq/Yt5SQ64j4JVtEwBAYGdOsCKHE7nkjw
 jddmYF1tSkgMHsSWRs9X9jADoTfKJhphysqh4ufMUFZIyI92+zpuAw7cAVqdkHtxlnEZp1xP+33
 as/djcZ6UXBXUw5j8JcJ/I6LCOcUbpVcufaYOY1q11Jub5QXLsfoQAzz+/ExdX+NHom5UEKHPE2
 tXvdyP15NzqLMtQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

> Send device_connect when a device is attached and the host has greeted
> us, device_disconnect when it goes away, and handle the bus reset the
> host sends before enumerating.
> 
> Wait a short time before sending device_connect. Firmware often toggles
> the USB pull-up a few times while it starts its controller. If the host
> starts to enumerate while the device is off, we cannot answer its first
> request, and it only retries after a control timeout of several seconds.

sigh, this is going to hit us as machine may behave differently. I think
we should make the redirect-server machine-agnostic then.

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


