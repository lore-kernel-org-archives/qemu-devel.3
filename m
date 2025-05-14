Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC43C3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 12:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAt5-0006Ob-QU; Wed, 14 May 2025 08:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uFAsS-0006CB-FE; Wed, 14 May 2025 08:06:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uFAsN-0001i4-3k; Wed, 14 May 2025 08:06:23 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CE9E355CA52;
 Wed, 14 May 2025 14:06:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id i5Hgu4y-3hfk; Wed, 14 May 2025 14:06:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D73A355CA4E; Wed, 14 May 2025 14:06:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D548F745682;
 Wed, 14 May 2025 14:06:14 +0200 (CEST)
Date: Wed, 14 May 2025 14:06:14 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Zhao Liu <zhao1.liu@intel.com>
cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org, 
 qemu-trivial@nongnu.org
Subject: Re: [PATCH 2/9] docs/devel/qom: Fix the doc about
 OBJECT_DECLARE_SIMPLE_TYPE
In-Reply-To: <20250514084957.2221975-3-zhao1.liu@intel.com>
Message-ID: <c179270c-d636-e20a-2043-38c09b81b4c6@eik.bme.hu>
References: <20250514084957.2221975-1-zhao1.liu@intel.com>
 <20250514084957.2221975-3-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-804930540-1747224374=:15654"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-804930540-1747224374=:15654
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 14 May 2025, Zhao Liu wrote:
> Currently, the expansion example of OBJECT_DECLARE_SIMPLE_TYPE "roughly"
> reflects what OBJECT_DECLARE_TYPE is doing.
>
> Why "roughly"? Because this line -
>
>>    G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)
>
> - is also wrong for OBJECT_DECLARE_TYPE.
>
> Fix the expansion example of OBJECT_DECLARE_SIMPLE_TYPE, especially
> drop that definition of MyDeviceClass.
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
> docs/devel/qom.rst | 11 +----------
> 1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
> index 5870745ba27b..185f4c2f5921 100644
> --- a/docs/devel/qom.rst
> +++ b/docs/devel/qom.rst
> @@ -326,21 +326,12 @@ This is equivalent to the following:
>    :caption: Expansion from declaring a simple type
>
>    typedef struct MyDevice MyDevice;
> -   typedef struct MyDeviceClass MyDeviceClass;
>
> -   G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDeviceClass, object_unref)
> +   G_DEFINE_AUTOPTR_CLEANUP_FUNC(MyDevice, object_unref)
>
> -   #define MY_DEVICE_GET_CLASS(void *obj) \
> -           OBJECT_GET_CLASS(MyDeviceClass, obj, TYPE_MY_DEVICE)
> -   #define MY_DEVICE_CLASS(void *klass) \
> -           OBJECT_CLASS_CHECK(MyDeviceClass, klass, TYPE_MY_DEVICE)
>    #define MY_DEVICE(void *obj)
>            OBJECT_CHECK(MyDevice, obj, TYPE_MY_DEVICE)
>
> -   struct MyDeviceClass {
> -       DeviceClass parent_class;
> -   };
> -
> The 'struct MyDevice' needs to be declared separately.
> If the type requires virtual functions to be declared in the class
> struct, then the alternative OBJECT_DECLARE_TYPE() macro can be

Maybe you need to adjust the text here about OBJECT_DECLARE_TYPE here and 
show how to define Class sturct?

Regards,
BALATON Zoltan
--3866299591-804930540-1747224374=:15654--

