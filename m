Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB149C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 19:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYsIT-0000Fm-RN; Fri, 17 Jan 2025 14:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <webczat@outlook.com>)
 id 1tYsIE-0000E2-13; Fri, 17 Jan 2025 14:46:16 -0500
Received: from mail-mw2nam10olkn20801.outbound.protection.outlook.com
 ([2a01:111:f403:2c12::801]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <webczat@outlook.com>)
 id 1tYsI9-00035I-Ow; Fri, 17 Jan 2025 14:46:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDi1BgXN4pwVUYoI0GcthYnNVQ6yHcV28aHy9n7JAD7Q6adzxfkeCk3ylC+bwJeOxufDFmf8swyD9Cza9YbAJcaXOAjbU8y75+VJEO1uqC3TJQ3Fszmt+oRTNX+lCOHcBHNdS9O6zN+xMjBbZzdSG9DOjug3Te/NBQfi7L3N26c4cpgADddw8BcUfA1gk+vEY7TW1b8h+gNMzmQjyDxWXrLdbW/WpLP3MFFzxGt8LtV+NVsiAJlzA6er56QOqMSyjTib21tn13YUQGbVur8ClFZY7aXeneO8dz0t/vO/DgDJCHx+biQ64RqZsvMnMmeVtdHu26jS9kWw2Ge/kaRoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er8kmPB5tHjZpcqj7hN4slLfMlAETgpCBCMHhtelBD8=;
 b=ynVoOPJL9WGuo9dI6g79l6LSxnizFJ1r/+yJCosb5/cvisZnvVsLowSvVFJiYbx+A3WInmTN8t0xJWYLJiUI3BjWyfG0e5ddRfX8dKhHDLATNKxsSVKZitQ1CaandXqwsrDoS3xB0x/cJcumuCVX11ENiPNBrLboFBp4RL8XH++ru6c7IpspHBq5zwiL3PxcR1wi0yc2K2TODP57Lb+VZrsZbrtVAtN5sMru0Pltl6wUs6xuqot7b5iSaEXzXxcYA0xe2e8kds+iyrryUqvJAhrb3dNWfv7AcA90wxaJGuSfEycZX3xI6lk3xb+czYRXLsNhQVABikWy/6CeUMkHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er8kmPB5tHjZpcqj7hN4slLfMlAETgpCBCMHhtelBD8=;
 b=GJ+kY6X7tZ84TtD94tKWhGUx+0DzJCAOxvqgMFH9rj2mRbk/8UBz0WeGXFlSBNiBE9DJSf57mS+rTURuWh0xvWV97wFecl3kp2WS2RvdPQxmDGusAUp+GCjpsAj2f8wXysmo6q1BZv9pd6h8dwyWHOCKgt/9FB5IMLUXzWmdw5hSS6UUBu1nADSWyy3KyTzCbUKS1hRrJa3s5p7TKArD/fN31WNXNdWAPUoDpap6Xs+75u6sJ/PP+mH28yJZudViH403TMM1wTvxU3HN+KMWNqnlGVan1JxexSMYmJKPHSTim8iLlacI9Ru4k+U7I2g+3u8xKyOi98THw16MTeBnGA==
Received: from SJ2P220MB1449.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:58c::10)
 by CH3P220MB2043.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:203::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 19:46:02 +0000
Received: from SJ2P220MB1449.NAMP220.PROD.OUTLOOK.COM
 ([fe80::e65:388e:1733:8f8a]) by SJ2P220MB1449.NAMP220.PROD.OUTLOOK.COM
 ([fe80::e65:388e:1733:8f8a%7]) with mapi id 15.20.8356.010; Fri, 17 Jan 2025
 19:46:02 +0000
Message-ID: <SJ2P220MB1449C7662A7731BA202450ABA01B2@SJ2P220MB1449.NAMP220.PROD.OUTLOOK.COM>
Date: Fri, 17 Jan 2025 20:45:57 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-discuss@nongnu.org, qemu-devel@nongnu.org
From: =?UTF-8?Q?Micha=C5=82_Zegan?= <webczat@outlook.com>
Subject: Nested virtualization with windows guest
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0018.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::13) To SJ2P220MB1449.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:58c::10)
X-Microsoft-Original-Message-ID: <8c465733-17f4-498c-9181-966c7eee9216@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2P220MB1449:EE_|CH3P220MB2043:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c96356a-4245-4ffd-61a7-08dd372f926f
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|8060799006|5072599009|461199028|19110799003|7092599003|15080799006|6090799003|30101999003|12091999003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGpybUtObU1yREtVckV2WE5sU2FkTEdTVVhVcGZkK1NEKy9EQjhjOXZMaU1Y?=
 =?utf-8?B?eHhXN3dHcTdIYXRZRlBNSjRWbWk2dkFVdW9tNDJ3R1pIN1hJUHhkR0VjeDRw?=
 =?utf-8?B?eVhRMXRIZ0t4TGV5Y3owaFZXWGVpVzFybDNCTFZFejREdUR2UTgvdlM3SkV6?=
 =?utf-8?B?Vkg4Yi9iYVRTSW1tWTM5Y2F1UGpmaVc3OFphTzZUMC8wZWN4RUNGUGE5VUow?=
 =?utf-8?B?RC9GR1cyK1dBWWIyL0dGc1NldFNSa3crSHVtTDI1ZXFnZ0NXa3lWTWthZE1K?=
 =?utf-8?B?azRDK3BWUnNjckp5YW91R3hJRXNzTDBiSGNyaVExeHhGMmc2WFkvQnU3VWpi?=
 =?utf-8?B?LzRnRUZJM2lCOTdiK3d5V1hkb1JyZmlCVmpObjBNWWpvMzNXaWFGTVJoTnBm?=
 =?utf-8?B?QUxLa3NNRjVjRVNCTHlxTFd4a0szQ1FlSU9haGRZc09sVEdUTmZ2dG1IZ1JR?=
 =?utf-8?B?QzdhVEc1cnRpUWpUaERIQ3pCTVVhKzRMZ3hFbkhYdzFDK2JTdjV1NWZyWlkw?=
 =?utf-8?B?WG02QldMZnpMSGNIZHpJV0hPNWtHRHlKZzVqSmlua2ZzMzd0TXZ0amRXQmtr?=
 =?utf-8?B?YkhjV3hkOWlEUGwrckJQNzM5cllNUUZmaUlIaWR2anZ4RkkydWNYOWRyQUFa?=
 =?utf-8?B?VHp2K3cvOXhPZFo2enNUbHJ2QXA1bHpRdGZtdE01VDRmM2hTK09jV2N2ZWll?=
 =?utf-8?B?d0wvcmZwa3JON1RSMWFreEE4V0ZCbDgwVVRYMldaUzlDWUQrdWNxVHVyTkJQ?=
 =?utf-8?B?NE02NTM5VGZvTU8yVGR2ZGtDMlJMcjRzTlJUOGNNeEVsTXViY1JiUnhIOWh5?=
 =?utf-8?B?NEJZNXpXbFFXaDJ2UmdlUW9HZzV2Z2JVL29uclZKL3ZyKzV5amtoSG9XdHda?=
 =?utf-8?B?SmFHV2NkekRTTWp6UER2R1YwRCt2a0cxWkxTTkJyNjJuV2xBOVZYMVFtSmRx?=
 =?utf-8?B?V3QrOFhibUhhUE5YQTA4eHhuMFZjYlBkU3c3TWd2bDU3ek04WXV6VDhwR3Rh?=
 =?utf-8?B?QVBvRlJMVTh6VlBhQVJTOG1Edjhqa1BvVURKNnRnNjZiMHVJSU9VTU45Yktm?=
 =?utf-8?B?VVZscW93dHFWY0I1bjk5OTBDUFRkYUc0Ulp3eGxPVzNJN3pOUUs1K08ySXdM?=
 =?utf-8?B?T0k0eHNiMGFVTXVXUVR6SWVOTU5BUzVhZDZCVUxpOThya2lPcWRYNTZCYUZp?=
 =?utf-8?B?dk1MMHgvdXBUM01HajhtOE5lYXF4YXFkZS95REdISUVBL0NoeURBYW5lMzJQ?=
 =?utf-8?B?TzE5K25hN2NXbndzZVlFUGJpVGZKWGtmQ2dOREJsMkJnOTk3bkJOUzBCd3Zu?=
 =?utf-8?B?V1FBWkhTYlBUMWI5d3hzMkliS1JpejdBZHFhUkJ5VTkvWWRwOWptQzNsQlpl?=
 =?utf-8?B?ekdRUUswb1oyanpDLzJ2WmFjK1RtVTF6QTFWV1R3QjJSSTUxQWtRWkNmdjIw?=
 =?utf-8?B?UHN5cFdQZldqMENXS3E1VlZSei9ueUVzQlJhNnpHOThiMlJhM3NvSWlaZ3hZ?=
 =?utf-8?B?L1VWUnpacm1FOG10TFc4Qmk2RS9RcDFoK1paWkxHRDRxeWY5YUJuSjM2R3ZL?=
 =?utf-8?Q?ebSlXxB2AZjBZQ1Zw/RebyDiM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkROOVN2RDJhOXc0Z1FmR0pxOTlRck1yYkFrb3l1aWpydUh1WjB6Z0VYYXA1?=
 =?utf-8?B?U1BnNEFYNDZxS2NyeXJiYWs1ZUJGVzloVXA2RlZ4SklPZVBsMC80eEhQUmsx?=
 =?utf-8?B?WXpObVdTSWdCcDBqaFRaTElBYzBRWFRoZmNYSTlvYU15cWN5b0FBQjJIUEMz?=
 =?utf-8?B?c3YrZzFPVUJGRkRqRHhiTE9yYXRTTEZMUWl0RFNHZEdvT1ZXZkdBaDJqajRj?=
 =?utf-8?B?SHM5OG9zTDZpdGY2UGJVS2ZvU0tHN1VrRjQyWEtEcDFUMVB4MURrQUZTQVdP?=
 =?utf-8?B?WXVJWitBR3lXd2dPTis4YzNvL0IzY0V2ZHNwR1Y3b1RXSXlkL1FnL0JVY2o2?=
 =?utf-8?B?YjNEampVbU9oSFpQV1QrNGdFaExobU5HMHd5cVNmekRnVkZwbko1SmFWdUFn?=
 =?utf-8?B?V25ZcytPcjhTUlh1OEFpaklUTSsyN2tQbWtjUGtjQTVhLzhrbkd5RWp1OGJR?=
 =?utf-8?B?ajlqY09QZjdWYUovNFhyWmN1VkJUeFlwUUxhL1dacW5JZ3o0MmFISkNkODFU?=
 =?utf-8?B?dkpHR3NvWnVCNjNrOGhyYzVsalQ4SUpwbVo0d0swMUFNSDdKME5JdVFkVXlz?=
 =?utf-8?B?MVZTUG1kdVlSU2lLbGNtYkVMTEVaZWpidGkyNC91ZUJmQlF1Ty9JTGJWZmJY?=
 =?utf-8?B?Tkwrc2RRVmg3VGpxR253TDRZVktvS2xnaVJUOXdvSDRmVkVKTm9wWmJPZVU3?=
 =?utf-8?B?UnNPUVBXMWVXTTRkTWFmYUc0ZjVvNnl5K2VpYU9sSmlCZUM0WkN2b0xWb1Fz?=
 =?utf-8?B?Z0dMRlp6TjlOWHJHdk45bXF3a1EwbmJlaC9LQjc3ZVgxTC8vL3pqWU1BanRa?=
 =?utf-8?B?ZkxzLytZdFF6N0JYd0dLTDQxS2kvMGlWdXRIWXNpV2I0c2VkT1VCVUlsL2o1?=
 =?utf-8?B?a0haN2JvUExRWThYaWxsQUtFSlNNV1ZvK09kUnNKQ3VveW9wZk5HUnI0MGF1?=
 =?utf-8?B?b2pHTnh4ZVJNYkNmbU9CVGN2QWNBRndlem8wQW9iQ3g5c1R6TDllS1lxSmdh?=
 =?utf-8?B?cGd6QktwdlFDakdkWTFZN0JsSkdGeS9abFBaTWFqVm5WbzNpOWloUlBibHpl?=
 =?utf-8?B?cGw1N3RNb285U3VNOEQwWEhFeGRha0V1dm82ZENLaWY3czZNbVNMa0xxcnNy?=
 =?utf-8?B?VHBIWml3NFQ0ZVl0aHJIUTZwbzlqclZwVzdKc1E0UjYxQy9QZnJRMXVaTytj?=
 =?utf-8?B?Y1M5Y0FMRHdxVHY5RXQ4ZWNuYmFJRVRCWXBLZE4vMytILzE3MVlHVURUMDBT?=
 =?utf-8?B?ZDhyWUdzT0NuaWhaeHkxblp5RGRWODlqQTF4NE9pQWdhODlaTG1kRmxlVCto?=
 =?utf-8?B?eEdHUUl6dFd4emxkcDNNdXVwU010VWc0dEZJcHU5aU5FRXM0NzdHb29GMUZh?=
 =?utf-8?B?N2U2MktZSlhNRU1JeERwMGM2RHI2bXcrSGpQMmk2MFo3bmdpUStVa2EzelEx?=
 =?utf-8?B?UjFXZCtpVEUrcW5hNTVQbWppL2wxR1hvQkh5elNyT2I1MmxKL1Boell1TUpN?=
 =?utf-8?B?WFAwdDBtMXBvM3dVU3JweXJEU2lkL0svQXkzU3EvNDh4aTQzRjRVcThFaE95?=
 =?utf-8?B?VGJIeVZxM2NESVMvaUxuOHh1S1lDbXhQbHljUUVCeTJCbi9NODFmVWxVdGh6?=
 =?utf-8?Q?dNL8VjM0kSyaPhHvEIThlKhF1H3juUd2CmzlW9z6aSt0=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c96356a-4245-4ffd-61a7-08dd372f926f
X-MS-Exchange-CrossTenant-AuthSource: SJ2P220MB1449.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 19:46:02.0012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3P220MB2043
Received-SPF: pass client-ip=2a01:111:f403:2c12::801;
 envelope-from=webczat@outlook.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello,


I am running on the host with intel alderlake (12'th gen) cpu which is 
i7 12700h, running fedora 40, linux kernel 6.12.8, qemu 8.2.8.

I run newest windows 11 as a guest, but this problem traces back at 
least to windows 10.

It works, until I enable hyperv. After that, it starts boot looping.

The only way to stop it boot looping is to disable hyperv, or the 
virtualization feature in cpu.

What could be the problem/how to fix it?

I have asked that before, but years are coming, this is not fixed, and 
workarounds I've found on forums don't work.


This is the libvirt log fragment containing qemu cmdline: Note it has 
hardware virtualization disabled, enabling it makes windows boot loop.


2024-08-27-14:14:13, ), qemu version: 8.2.8qemu-8.2.8-2.fc40, kernel: 
6.12.8-100.local.fc40.x86_64, hostname: wlap
LC_ALL=C \
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin \
USER=root \
HOME=/var/lib/libvirt/qemu/domain-1-win11 \
XDG_DATA_HOME=/var/lib/libvirt/qemu/domain-1-win11/.local/share \
XDG_CACHE_HOME=/var/lib/libvirt/qemu/domain-1-win11/.cache \
XDG_CONFIG_HOME=/var/lib/libvirt/qemu/domain-1-win11/.config \
XDG_RUNTIME_DIR=/run/user/1000 \
/usr/bin/qemu-system-x86_64 \
-name guest=win11,debug-threads=on \
-S \
-object 
'{"qom-type":"secret","id":"masterKey0","format":"raw","file":"/var/lib/libvirt/qemu/domain-1-win11/master-key.aes"}' 
\
-blockdev 
'{"driver":"file","filename":"/usr/share/edk2/ovmf/OVMF_CODE.secboot.fd","node-name":"libvirt-pflash0-storage","auto-read-only":true,"discard":"unmap"}' 
\
-blockdev 
'{"node-name":"libvirt-pflash0-format","read-only":true,"driver":"raw","file":"libvirt-pflash0-storage"}' 
\
-blockdev 
'{"driver":"file","filename":"/var/lib/libvirt/qemu/nvram/win11_VARS.fd","node-name":"libvirt-pflash1-storage","auto-read-only":true,"discard":"unmap"}' 
\
-blockdev 
'{"node-name":"libvirt-pflash1-format","read-only":false,"driver":"raw","file":"libvirt-pflash1-storage"}' 
\
-machine 
pc-q35-7.2,usb=off,smm=on,kernel_irqchip=on,dump-guest-core=on,memory-backend=pc.ram,pflash0=libvirt-pflash0-format,pflash1=libvirt-pflash1-format,acpi=on 
\
-accel kvm \
-cpu 
host,migratable=off,vmx=off,kvmclock=on,hv-time=on,kvm-pv-eoi=on,kvm-pv-unhalt=off,hv-passthrough=on,hv-crash,kvm-pv-ipi=off,pmu=on 
\
-global driver=cfi.pflash01,property=secure,value=on \
-m size=8388608k \
-object 
'{"qom-type":"memory-backend-memfd","id":"pc.ram","share":true,"x-use-canonical-path-for-ramblock-id":false,"size":8589934592}' 
\
-overcommit mem-lock=off \
-smp 8,sockets=1,dies=1,clusters=1,cores=8,threads=1 \
-uuid 8c101ee1-29e1-43f8-9136-e9b6066ed4d6 \
-no-user-config \
-nodefaults \
-chardev socket,id=charmonitor,fd=23,server=on,wait=off \
-mon chardev=charmonitor,id=monitor,mode=control \
-rtc base=localtime,driftfix=slew \
-no-shutdown \
-boot strict=on \
-device 
'{"driver":"intel-iommu","id":"iommu0","caching-mode":true,"device-iotlb":true}' 
\
-device 
'{"driver":"pcie-root-port","port":16,"chassis":1,"id":"pci.1","bus":"pcie.0","multifunction":true,"addr":"0x1"}' 
\
-device 
'{"driver":"pcie-root-port","port":17,"chassis":2,"id":"pci.2","bus":"pcie.0","addr":"0x1.0x1"}' 
\
-device 
'{"driver":"pcie-root-port","port":18,"chassis":3,"id":"pci.3","bus":"pcie.0","addr":"0x1.0x2"}' 
\
-device 
'{"driver":"pcie-root-port","port":19,"chassis":4,"id":"pci.4","bus":"pcie.0","addr":"0x1.0x3"}' 
\
-device 
'{"driver":"pcie-root-port","port":20,"chassis":5,"id":"pci.5","bus":"pcie.0","addr":"0x1.0x4"}' 
\
-device 
'{"driver":"pcie-root-port","port":21,"chassis":6,"id":"pci.6","bus":"pcie.0","addr":"0x1.0x5"}' 
\
-device 
'{"driver":"pcie-root-port","port":22,"chassis":7,"id":"pci.7","bus":"pcie.0","addr":"0x1.0x6"}' 
\
-device 
'{"driver":"qemu-xhci","id":"usb","bus":"pci.3","multifunction":true,"addr":"0x0"}' 
\
-device 
'{"driver":"virtio-scsi-pci","iommu_platform":true,"ats":true,"id":"scsi0","num_queues":8,"bus":"pci.3","addr":"0x0.0x1"}' 
\
-device 
'{"driver":"virtio-serial-pci","iommu_platform":true,"ats":true,"id":"virtio-serial0","bus":"pci.3","addr":"0x0.0x2"}' 
\
-device '{"driver":"ide-cd","bus":"ide.1","id":"sata0-0-1","bootindex":2}' \
-blockdev 
'{"driver":"host_device","filename":"/dev/pool/win11","aio":"io_uring","node-name":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}' 
\
-blockdev 
'{"node-name":"libvirt-1-format","read-only":false,"discard":"unmap","driver":"raw","file":"libvirt-1-storage"}' 
\
-device 
'{"driver":"scsi-hd","bus":"scsi0.0","channel":0,"scsi-id":0,"lun":0,"device_id":"drive-scsi0-0-0-0","drive":"libvirt-1-format","id":"scsi0-0-0-0","bootindex":1}' 
\
-chardev 
socket,id=chr-vu-fs0,path=/var/lib/libvirt/qemu/domain-1-win11/fs0-fs.sock \
-device 
'{"driver":"vhost-user-fs-pci","id":"fs0","chardev":"chr-vu-fs0","tag":"shared","bus":"pci.5","addr":"0x0"}' 
\
-netdev 
'{"type":"tap","fds":"24:26:27:28:29:30:31:32","vhost":true,"vhostfds":"33:34:35:36:37:38:39:40","id":"hostnet0"}' 
\
-device 
'{"driver":"virtio-net-pci","iommu_platform":true,"ats":true,"mq":true,"vectors":18,"netdev":"hostnet0","id":"net0","mac":"52:54:00:4e:aa:fc","bootindex":3,"bus":"pci.4","addr":"0x0","rombar":1,"romfile":"/usr/share/ipxe/qemu/efi-virtio.rom"}' 
\
-chardev pty,id=charserial0 \
-device 
'{"driver":"isa-serial","chardev":"charserial0","id":"serial0","index":0}' \
-chardev spicevmc,id=charchannel0,name=vdagent \
-device 
'{"driver":"virtserialport","bus":"virtio-serial0.0","nr":1,"chardev":"charchannel0","id":"channel0","name":"com.redhat.spice.0"}' 
\
-chardev socket,id=charchannel1,fd=22,server=on,wait=off \
-device 
'{"driver":"virtserialport","bus":"virtio-serial0.0","nr":2,"chardev":"charchannel1","id":"channel1","name":"org.qemu.guest_agent.0"}' 
\
-chardev socket,id=chrtpm,path=/run/libvirt/qemu/swtpm/1-win11-swtpm.sock \
-tpmdev emulator,id=tpm-tpm0,chardev=chrtpm \
-device '{"driver":"tpm-crb","tpmdev":"tpm-tpm0","id":"tpm0"}' \
-object 
'{"qom-type":"input-linux","id":"input0","evdev":"/dev/input/by-id/usb-MOSART_Semi._2.4G_INPUT_DEVICE-event-kbd","repeat":true,"grab_all":true,"grab-toggle":"ctrl-ctrl"}' 
\
-object 
'{"qom-type":"input-linux","id":"input1","evdev":"/dev/input/by-path/platform-i8042-serio-0-event-kbd","repeat":true,"grab_all":true,"grab-toggle":"ctrl-ctrl"}' 
\
-object 
'{"qom-type":"input-linux","id":"input2","evdev":"/dev/input/by-path/pci-0000:00:15.0-platform-i2c_designware.0-event-mouse"}' 
\
-device '{"driver":"usb-tablet","id":"input5","bus":"usb.0","port":"3"}' \
-device '{"driver":"usb-kbd","id":"input6","bus":"usb.0","port":"4"}' \
-audiodev '{"id":"audio1","driver":"pa"}' \
-spice 
port=0,disable-ticketing=on,gl=on,rendernode=/dev/dri/renderD128,seamless-migration=on 
\
-device 
'{"driver":"virtio-vga","id":"video0","max_outputs":1,"bus":"pci.2","multifunction":true,"addr":"0x0"}' 
\
-device 
'{"driver":"ich9-intel-hda","id":"sound0","bus":"pci.2","addr":"0x0.0x1"}' \
-device 
'{"driver":"hda-micro","id":"sound0-codec0","bus":"sound0.0","cad":0,"audiodev":"audio1"}' 
\
-device 
'{"driver":"i6300esb","id":"watchdog0","bus":"pci.1","multifunction":true,"addr":"0x0"}' 
\
-global ICH9-LPC.noreboot=off \
-watchdog-action reset \
-chardev spicevmc,id=charredir0,name=usbredir \
-device 
'{"driver":"usb-redir","chardev":"charredir0","id":"redir0","bus":"usb.0","port":"1"}' 
\
-chardev spicevmc,id=charredir1,name=usbredir \
-device 
'{"driver":"usb-redir","chardev":"charredir1","id":"redir1","bus":"usb.0","port":"2"}' 
\
-device 
'{"driver":"virtio-balloon-pci","iommu_platform":true,"ats":true,"id":"balloon0","deflate-on-oom":true,"free-page-reporting":true,"bus":"pci.1","addr":"0x0.0x1"}' 
\
-object '{"qom-type":"rng-builtin","id":"objrng0"}' \
-device 
'{"driver":"virtio-rng-pci","iommu_platform":true,"ats":true,"rng":"objrng0","id":"rng0","bus":"pci.1","addr":"0x0.0x2"}' 
\
-device '{"driver":"vmcoreinfo"}' \
-sandbox 
on,obsolete=deny,elevateprivileges=deny,spawn=deny,resourcecontrol=deny \
-device '{"driver":"pvpanic"}' \
-msg timestamp=on


