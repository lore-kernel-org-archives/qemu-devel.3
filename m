Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F80CF53D69
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 16:06:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2ARn-0002bK-3z; Mon, 16 Mar 2026 12:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2ARk-0002ae-42
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:05:36 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1w2ARb-000188-SC
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 12:05:33 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E96D9596A46;
 Mon, 16 Mar 2026 17:05:17 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id t2CAgGi-cJqp; Mon, 16 Mar 2026 17:05:15 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D5379596A41; Mon, 16 Mar 2026 17:05:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id D332B5969F9;
 Mon, 16 Mar 2026 17:05:15 +0100 (CET)
Date: Mon, 16 Mar 2026 17:05:15 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
cc: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Zide Chen <zide.chen@intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
 qemu-devel@nongnu.org, devel@lists.libvirt.org, 
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v2 00/21] qom: introduce property flags to track external
 user input
In-Reply-To: <87tsufpyo5.fsf@pond.sub.org>
Message-ID: <96b88815-b01a-8d9c-0400-5d881bc9e6c0@eik.bme.hu>
References: <20260210032348.987549-1-zhao1.liu@intel.com>
 <877bricy97.fsf@pond.sub.org> <abFqwbCCf7rNDEWs@redhat.com>
 <87tsufpyo5.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 16 Mar 2026, Markus Armbruster wrote:
>> More generally anything we can do to bring qdev & qom closer together
>> feels desirable. I dream of a future where -device/device_add are
>> obsolete....
>
> That would be lovely.

How would normal people add devices from the command line then? Do you 
expect us to use -object or something like that with JSON instead? That's 
very impractical so some command line UI should remain. Also is it 
practical to force people to learn some QEMU specific language to be able 
to write device models? Otherwise what advantage this gives over doing it 
in C? I think these are questions to answer before getting into the 
design.

Regards,
BALATON Zoltan

