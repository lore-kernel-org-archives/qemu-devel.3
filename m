Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2799CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGNxI-0000Wk-Mh; Mon, 12 Oct 2026 17:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGNxH-0000W6-5R
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:53:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGNxF-0006RK-Qy
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 17:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791841989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hvRdGjmV0ppxdqjb1nHh6IosNEj3IaKtvWrxkVjnp00=;
 b=XZo4haoLVLITnl+Ts5rOUmO0F4nvwUFhw82xoicouwR8GaSixYJECu/f41ugLwqGOpITDd
 aPwaeVD2YXB1jMSq02Pkpa6OckTWT7nabOfAw2eqPhNkqJMN15pqt7DWvfHB32AyyciQoQ
 3YOEHYwn03+ixlSeLB0/2qoPdzQL9WE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-Hj2CfromN7KNu2c3fyYLMg-1; Mon,
 12 Oct 2026 21:53:05 +0000
X-MC-Unique: Hj2CfromN7KNu2c3fyYLMg-1
X-Mimecast-MFC-AGG-ID: Hj2CfromN7KNu2c3fyYLMg_1791841982
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92C4F1956055; Mon, 12 Oct 2026 21:53:02 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 982CB18004D2; Mon, 12 Oct 2026 21:53:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 15/16] tests/functional: update s390x tuxrun images
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Brad Smith <brad@comstyle.com>, Ani Sinha <anisinha@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, Keith Busch <kbusch@kernel.org>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Anders Roxell <anders.roxell@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Warner Losh <imp@bsdimp.com>, 
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, Peter Xu <peterx@redhat.com>, 
 Klaus Jensen <its@irrelevant.dk>, Song Gao <gaosong@loongson.cn>, 
 qemu-s390x@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261012170330.1144446-16-alex.bennee@linaro.org>
References: <20261012170330.1144446-1-alex.bennee@linaro.org>
 <20261012170330.1144446-16-alex.bennee@linaro.org>
Date: Tue, 13 Oct 2026 01:52:29 +0400
Message-Id: <179184194937.2190936.3981100108318633267.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=362;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wx8HHLzmakCEvbSWMDTud8ToP+RykOdtopxEd6sBaQ0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzVaggpAUv7uPdqWChvDmZXYWdFA1K99WIOMm2
 0MzZg8ZoV6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1WoAAKCRDa6OEJdZac
 5ThrEACDvh3J6wXeNz1kcsc1B4rayCKQI5O71vJ5u4sAO+3wWSsH+ke0J+X0Nwi6ltEyMv5Pu73
 Lnxvodo3j4IcNrntAvzKqTfVSZOOSmYTgGjXf4VSrH+CoOess9+pTBuDO7eMd2T4l8LnxZEegFd
 IKuo/e2auBuUTFAjWpVAEtrmhUAZr/a4OkfBMGMfkx+triDhpEAIEufvW4lBtjl9DQ90bpP1rdw
 eG9COLTPPLLCErAOCcPbWiACoNcefKNEY6IW3G9TDCFs1sPgOiI/aZ/bnTaCUjAUMY9OErLndix
 m4/7y5ptEGF01/MwwX99Crbnc30xYwkGG4mbJz6118RW+7XilFb8nziD37zTkfjUpSVRJx43tGu
 w4z3EcKHPyVvFB9k9N/ng4D3lT2l7Fq+Y5BszwvgT5pZAIX6z4Jscg63lMpi87xZ1iYiDHSGQKq
 TIZPR8YPc30fwg1VU+bvLAPUDW4aHJ8hr557UfUL3wZoKbcBDU6iksx0/fswW18nsjKyLnChPyq
 3PMSA3q/kggY/gP89QQG4x5awHladTQX+yzCoAooJp8E+t1vfaEhMEB/trP7eeYnWVo2BpvI+fX
 JMjZOsauzSOxpcSelsylFBV4QhQ+1+aBdGmpaxdDwoXJ6ag/NGLs9Ny154EZZRQyFlU4zufrs6B
 njjai8RO01TEYeA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

On Mon, 12 Oct 2026 18:03:29 +0100, Alex Bennée <alex.bennee@linaro.org> wrote:
> We now split the fetching of the buildroot image from the kernel
> itself. This is because we will want to access additional metadata in
> future tests.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


