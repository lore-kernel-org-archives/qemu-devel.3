Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33E1C5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 06:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuOqB-00089b-Kf; Thu, 13 Aug 2026 02:22:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wuOq9-00088q-Jy
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 02:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wuOq7-0002sC-8v
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 02:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786602173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5cT1nmc7vVtN8cC2Gt7uLxthvWRI1Z3KeLTQUmU5gI=;
 b=V7WmvZZl4IINtuECbEmoXc7irgcU7SsGzGKZMHQHaqbmvA2wJpCBQSqknoaO1JWrG49uzQ
 XjPiNz8fsDUfRjDEQe5SKRmjc1oB+uyahtMBeECVAxmGBAM7nh0bFpuak3S3OeTkkTCZeX
 xo6kP876tpg2cJg5wXYr447Z1Q447kY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-gNmEi-HWPuOJNSddHT8-Dg-1; Thu,
 13 Aug 2026 02:22:39 -0400
X-MC-Unique: gNmEi-HWPuOJNSddHT8-Dg-1
X-Mimecast-MFC-AGG-ID: gNmEi-HWPuOJNSddHT8-Dg_1786602158
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7584A19560AD; Thu, 13 Aug 2026 06:22:38 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6420019560AB; Thu, 13 Aug 2026 06:22:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 11/23] monitor: Remove unnecessary 'block/block.h'
 header
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20260812211708.92824-12-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
 <20260812211708.92824-12-philmd@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 10:22:28 +0400
Message-Id: <178660214824.3552881.13219958238684036409.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=284;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=O2NkNdblDLT1vAVVhVH++nsJrPkaXoyGuNVLBvZ4OUA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqfWKmA7kcu/J6fUSKqCpv4DPtpiaVno56W+lNp
 yqw8kD9nrSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCan1ipgAKCRDa6OEJdZac
 5c7nEACuFLoiCtWszXCX9D05KvOUC7ay/3//n+y+HSoFxL+EgIX9NkDGrCZ54XoWREALfIduqhj
 Obd3TFP/BTZ5IWeRtEBJbYbKNhpfnP+qN7tLpBPLC3g5FVa2jyHEqnc3eoGdUxVarrsp44aG94e
 84RGAUxzAJJWKlYrn5dqSsnWSrkjsRdeGvLXtmcn7fRjmLw+oCxSU05y91JXpQHFR9W/vxJ+2tQ
 b0EtekA4AwwUdu/syOA+SoeKYJ7tf6yTv4WmufkXAxqYr4JKLv2VJj/56yA2bgyrWs0VaNKPmmJ
 8iY1eLiknTouX7Rs8ro3QMBI6ceJrPMnkNY4aSW3S63H0zaZ991YkfRVWJRtjAKaELWIyN5h9qX
 IRcW7VWqXMNE/kB8PusGRMOLaB2rZk5CvzPCCWQqyBCJoGBX6YRJkzCKQvOinEbPJ0x8L6EvV5M
 EjnfLczzdLJQYyIe5r5Xj3gleAh6wdNCT+REhaiIK48klh4Mx+KCT4hlcEYgtKF5/f/TFVDyVIx
 5IDvtxy6HdwoK1FSL+/RfqPNsUSnUdgNbPUWhCkBdJXQIMfVP9V2Y/lLW7BsCPRv16blYr8Jbzo
 r4oKb/XxJ/2A4lEXRxo2MUdbO9t5/wjPPYXrEE4dmTd6mpyJMDYQRSRnyxryBztOGYFQwbn0mQS
 AxKERMkchtA7Dlg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 12 Aug 2026 23:16:55 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> Nothing here requires declarations from "block/block.h" anymore.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


