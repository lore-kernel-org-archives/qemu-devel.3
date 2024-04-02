Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCDB9CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 12:43:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrdSe-0007wh-II; Tue, 02 Apr 2024 08:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1rrdSd-0007wN-RO
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 08:41:55 -0400
Received: from mail-dm6nam12on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2417::701]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1rrdSb-0003N1-1z
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 08:41:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YalZFqx05sDA6gR3pwbVQZSq3TkcEQgqMHthQfWSTZ8qFvxHWj2dTklfFlY4D6zbdCbT9hc271qFux1sdy4WYZ4VuR4sNXd2JbEMVDu/uQmfAeppmKfpwQRbs2mS6uq+a6rrUEZgXgABtfaQXPV6DgbOP/6+drsubN+OnisGlaabaQeeYDXHkI7ExIA6ik13aNkCnT0EzIBfuQPSm7uakexeU/vqi8C30lUdV4c4QMuGwVbz5qzoZoOMouwElbfcSAl7KZXVMUa0Y+H1Jm3N+U35jMAZqZ46bpRdEmG0syMM2J47LzOIyl4iXllZyY53swsxnruTOVD5Ie8gbAZN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zn+KEov11VzSIX9zDYgtDQ9qYFCpbAxp8OjFWUF9NDA=;
 b=d5XVrbEjAljiZlSM8s2qisamop8liGWvuqlyu3PQ5wLSYgMnnsgDuKHZE8Nbhi7fV+vW8TytVp3OTu1ZPJ8b8vQGaSLTLw5M4vKP/7qIXhvgpf+4pN0GW+7m+/gaq7BzcCIN2DTHJ/zP8Q/tPtQIZAKqGmwGIgkrbSc9VD4Er8eojaRKKrg7RIQK2on6onIhKAB6ijUvwmkPmzvyW+GWvtSggOxYjkYLOJIzAo/CIssqMm6UK6XpVxjkG0Jp1wGkmrCP9ueAk9AYvpG2co9HjiOXXWwI8QntBzVQU/1wEk2hy5RAIIIYiZSTOwb7IrgX4+VU4MKadQmYKwu4AugL+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zn+KEov11VzSIX9zDYgtDQ9qYFCpbAxp8OjFWUF9NDA=;
 b=lWqqpIQplTFkjmz8STw7O35pgkOn0/ugdTdvxvOuubIxajy1OtMAUUekMLvdWm7C4ziw/p79KV9Xu3jmMnQ3EHh7aYr+x8EEy4QYu/U6/W1V4YTaP8S3PTYDrUIfUS5yj1GmIMIwwOX/F0FJTCAxTuTvPs4xgDJ64SzY4Spi53WHqatgvEvfradpXO1XtrzoeJjiwCMzLXkFDwtSRJNo+fMXCgyR6eNSUSLOREiG9rY9xsleZYLmESI4XM4z+O6ZpsAcdEIAqqq7BJrYHlDWyuOVzOWK+QAMQy7wKEqFCzXPMLn+k8p8X3bcz7HtsOANj08hqTx756qwk2+IqUBrPQ==
Received: from DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) by
 CYYPR12MB8703.namprd12.prod.outlook.com (2603:10b6:930:c4::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Tue, 2 Apr 2024 12:41:44 +0000
Received: from DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::449b:329d:c9cd:5824]) by DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::449b:329d:c9cd:5824%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 12:41:42 +0000
Message-ID: <7014db95-617b-4f7e-8c2a-cc639c089969@nvidia.com>
Date: Tue, 2 Apr 2024 20:41:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: fix qemu set used ring flag even vhost started
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>,
 "maxime.coquelin@redhat.com" <maxime.coquelin@redhat.com>
Cc: Jiri Pirko <jiri@nvidia.com>
References: <20240402045109.97729-1-yajunw@nvidia.com>
 <059cb96a-ac0b-4266-bd6e-8911c387baeb@linaro.org>
Content-Language: en-US
From: Yajun Wu <yajunw@nvidia.com>
In-Reply-To: <059cb96a-ac0b-4266-bd6e-8911c387baeb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0060.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::24) To DM4PR12MB5168.namprd12.prod.outlook.com
 (2603:10b6:5:397::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5168:EE_|CYYPR12MB8703:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bQQst+PSfVrpjuYuJeaRt0Bet04uCcKx7jgEFuWWQBQ2R5GU3CkpxedTLa9hSyO+AOswFqRszNKi2dOXsX/SW4FleSmMxoJzgNLX88A/mS87kGM7o0jzT35I8giLgj0qpS5XMuRhGbouWHD1/o6OPVzdPnYAt3PTmXPB2Nfxlb2WGJbEKyvfUnrlEsjnykatsWFq9yJkHCL7kQivSXFaXTI16zPF6VhaaEt9pUz1vkgPPU3AjVYCN7mm/nCuSEwULXg1LW5/cLqCWCyTp5qIf0ni+bEjIb4+ULjPbfz54B5g7l8W/jYRN2vGa5UIMQDG7TR4n2N4GOvM4KCEAUxMCWPqj88GcFBV27i/ldMu/37nrUEUCEwKK2W0CqiwMEVdG6T63LXcU/lQBsS0Ij/GzK3AXnKdi4lEug6NJupUoyEqquDW4P64S5E9GtFNws6JSX0pHVZuzNfLdJtGQ5Vl3LC8YpFHOggimQAMYp/q+2iBRWG6ApPCK3+Q2gP4gS4j92kWRtGQ4u3M6FW3lY70bUdiUgTqd5st8nZ/pTKweW3J6q1/c337PeT4aP3SyxHQR5BCI7lPM5Kp8DhYUQ5VO1YyUa1tnweV3XR/HXDETljl8p/tYfrzAvZYg238wbNal2C/9yusdhe6I6zAoLeHjhUDypT/5h5wYjuTAvzwcS8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5168.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uy9zV3hwdkR3dXNjaTAyVFJxRGROTDByYWlPaFhTODdRMVNPL2tCZ3VpdkxL?=
 =?utf-8?B?Z29POEFGczBCRGU0dTdpUXQ4QXkzaDQyTmtiL2pXc2t2TVdIOG5iVHpOMjV6?=
 =?utf-8?B?NzV2dC9xdXZTR1Z5V3dqc0dHQ2k0WWxmRk5KamlLS3BZQmx4dTVqLzZuWklh?=
 =?utf-8?B?OXRDeFJQV1cwc2NyOGI2UWtTNTFBNXhHOVMzUEpkL29MOEpmaitpOXJ5WHpV?=
 =?utf-8?B?bFBlOVRrVTd1OVAvQXFNR01wR2NRaUxSSUFiTmdqeGV3OHJTcklHZmRzMGZP?=
 =?utf-8?B?b3UrN3pldks3Y1plem5od3kwNFlwQXY1Zlg4NDhIUGRiVUc4c3o4R2VZRnQy?=
 =?utf-8?B?RThsUWJ1OThrTFF4eWJoOUdWOE1id0JZZ0tWSjdPYXBUTXN3SDBiTzdQc0JX?=
 =?utf-8?B?dGhGLzF4K2MrQzBiQjA0djBiK1dSV3BLR3EzYXZPUWFlVlhqOTRsdTQ4UGxm?=
 =?utf-8?B?OFlWcDYybzhmbVNvQnd3OWZxanpCWHlxbEJtSUY1M2VMc1plY3ZaL3Q4Nmgz?=
 =?utf-8?B?eVRwMEpSeVVkNkt2cElCZ2I1UEV4TEg5MmZ5TzByRXBYQ1BBYXM0b1FSUGxM?=
 =?utf-8?B?dWlETDE5R2NxSVZ0S3E0b1RsQUVrWVF3UDJ3cDRVM2VTTk9WRHlRYnBzQ1F2?=
 =?utf-8?B?WlMwUWpZQW5RTG12Q0Z3MHJkTWhIOFFxT20xUlBOYnRBeTF6OWs0Z1dYZ3M5?=
 =?utf-8?B?VFVmWkUyeThwck5lWVE0a21mOTJNZm0wc0xRcGRNcExKcG5oM0NyZUFlNnZq?=
 =?utf-8?B?L3l2UndLeGFZRGcxY0RGT0RuN1gyNk5tYkczUi9FU0tZZDl1aFl5aUFQeGhM?=
 =?utf-8?B?L1N5Rm95RWZEV2pza2xGREMzOGJVVHV5Yml1bDhpazlXMUUzdHdIZWV6Tmoy?=
 =?utf-8?B?QUJIbFNkanBRWnU3TTBDWEpXKytBckpUKzJLSmQ4RGFoK2hXS3hxSlVWelNH?=
 =?utf-8?B?emZIaHhRemd3UHFERjRKcDR3YUMxWXdJVzZKejBRYU0zTGtFTS95WmxrNHpC?=
 =?utf-8?B?TisrcmhDWndhN0FBMzZRN3ZucWV6N2JrUG9La3ViQzJiVjVkZWdUbGdOY3BM?=
 =?utf-8?B?MjBldGwyMkk3cXlnU2I0ajZ2K2h5a1J1NTNaK0JVVnU4dVlrRk53SXU5Z0x6?=
 =?utf-8?B?eUY2NVZaTXdBeVpWMlVkVm43bC9DYlZPcUhyODJlS1dwQ1U4aTVtWkNkWXZ5?=
 =?utf-8?B?UytxNENsL0pCakRSY2lJazFZWk9naUQrVkVQL1hqSWplR1BsdG1HazdwOGFX?=
 =?utf-8?B?MERZcXY2TUl0YmtRSm9ma1daNXlJSENQUWVUTTcwQUF2SWQ4SHNMaWJQSW5v?=
 =?utf-8?B?aFE1R1ZvWnRTOWRKaFVoUXRpdnRFUi82MSsyZXdxNXVsZHlReExhK25oRXEr?=
 =?utf-8?B?RmJ0TnRDVnZ3U1Nyc0ZiUjRlUkc3emlMR2FJQVRMWmFPbzVDT3RnSFYrTjc4?=
 =?utf-8?B?OXFaaFpHMU9JYzAyUk1tQUM3M3psV0FOeUdWSDNMeW5pRGMxTk96V2svZDZq?=
 =?utf-8?B?Q3UxeFJyMlBNVFhiYkd1bmRDUHI0cHp0bVZpWEtIR2V2aDVPL24vSEoxb3dI?=
 =?utf-8?B?SUZ0K1RHT2phbitWdThCMXF1S0F0dU1xMmw5WUtJTisrTm1FclMzem5DNDBN?=
 =?utf-8?B?clhlN2JUU1ZvVUN3UlRIUW96b28wRFpabzRZOEFwVWllMDhvc2JXVHBRZVpj?=
 =?utf-8?B?enY2MWpCeGt4VHZQMWh2dzgrK0JwbDFwUWtWYjFmUS9PUllCZGFvRVMzRVlx?=
 =?utf-8?B?ZW9nS05kY3YrT0JLYXpwZ0xMZ1EzQkMweGg4bkJ0MXVVNWVMa1lXdERjMVZo?=
 =?utf-8?B?WHdzajVFcjRka1NMSnY0eHZyMkNrVUR3NS9NN0tMSE1GVEVmcjE3eXh1akFQ?=
 =?utf-8?B?eTk4ZkJCTE5wU1piNTZtWllDaG1LdktsazlIS3pYN0pvaml6VnRWQm95elFr?=
 =?utf-8?B?cCtiRGI1Uld5YmlSUGdvSnB2MGhLN2M0Z2NGM3JuV2MzdnFMekVMVDg4bmd2?=
 =?utf-8?B?VlM5UHlVY0grM21XczRqY2c3U0NCRVByMXJkNStjdDlGb1Jnc1dVc1VBUk5W?=
 =?utf-8?B?TVJoellzblVkeU5rcDRNb2NSekJ1ODJzMnluYTZyNUNZeGoyZXNoK2trTTBY?=
 =?utf-8?Q?zQGLyHthur8ILBCETUjhKrXOg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54576d7b-5adc-4a51-509c-08dc53123f4e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 12:41:42.0414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ha5D7v7MLLGj7+TN2FGUBUAouvpPKOYbOUrsWHJDlkI5MLVmFbwkOFQcHcpyY0Q2ASRw/pOref4O+POgGSaA7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8703
Received-SPF: softfail client-ip=2a01:111:f403:2417::701;
 envelope-from=yajunw@nvidia.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


On 4/2/2024 8:11 PM, Philippe Mathieu-Daudé wrote:
> External email: Use caution opening links or attachments
>
>
> Hi Yajun,
>
> On 2/4/24 06:51, Yajun Wu wrote:
>> When vhost-user or vhost-kernel is handling virtio net datapath, qemu
> "QEMU"
Ack.
>> should not touch used ring.
>>
>> But with vhost-user socket reconnect scenario, in a very rare case (has
>> pending kick event). VRING_USED_F_NO_NOTIFY is set by qemu in
> "QEMU"
Ack.
>> following code path:
>>
>>        #0  virtio_queue_split_set_notification (vq=0x7ff5f4c920a8, enable=0) at ../hw/virtio/virtio.c:511
>>        #1  0x0000559d6dbf033b in virtio_queue_set_notification (vq=0x7ff5f4c920a8, enable=0) at ../hw/virtio/virtio.c:576
>>        #2  0x0000559d6dbbbdbc in virtio_net_handle_tx_bh (vdev=0x559d703a6aa0, vq=0x7ff5f4c920a8) at ../hw/net/virtio-net.c:2801
>>        #3  0x0000559d6dbf4791 in virtio_queue_notify_vq (vq=0x7ff5f4c920a8) at ../hw/virtio/virtio.c:2248
>>        #4  0x0000559d6dbf79da in virtio_queue_host_notifier_read (n=0x7ff5f4c9211c) at ../hw/virtio/virtio.c:3525
>>        #5  0x0000559d6d9a5814 in virtio_bus_cleanup_host_notifier (bus=0x559d703a6a20, n=1) at ../hw/virtio/virtio-bus.c:321
>>        #6  0x0000559d6dbf83c9 in virtio_device_stop_ioeventfd_impl (vdev=0x559d703a6aa0) at ../hw/virtio/virtio.c:3774
>>        #7  0x0000559d6d9a55c8 in virtio_bus_stop_ioeventfd (bus=0x559d703a6a20) at ../hw/virtio/virtio-bus.c:259
>>        #8  0x0000559d6d9a53e8 in virtio_bus_grab_ioeventfd (bus=0x559d703a6a20) at ../hw/virtio/virtio-bus.c:199
>>        #9  0x0000559d6dbf841c in virtio_device_grab_ioeventfd (vdev=0x559d703a6aa0) at ../hw/virtio/virtio.c:3783
>>        #10 0x0000559d6d9bde18 in vhost_dev_enable_notifiers (hdev=0x559d707edd70, vdev=0x559d703a6aa0) at ../hw/virtio/vhost.c:1592
>>        #11 0x0000559d6d89a0b8 in vhost_net_start_one (net=0x559d707edd70, dev=0x559d703a6aa0) at ../hw/net/vhost_net.c:266
>>        #12 0x0000559d6d89a6df in vhost_net_start (dev=0x559d703a6aa0, ncs=0x559d7048d890, data_queue_pairs=31, cvq=0) at ../hw/net/vhost_net.c:412
>>        #13 0x0000559d6dbb5b89 in virtio_net_vhost_status (n=0x559d703a6aa0, status=15 '\017') at ../hw/net/virtio-net.c:311
>>        #14 0x0000559d6dbb5e34 in virtio_net_set_status (vdev=0x559d703a6aa0, status=15 '\017') at ../hw/net/virtio-net.c:392
>>        #15 0x0000559d6dbb60d8 in virtio_net_set_link_status (nc=0x559d7048d890) at ../hw/net/virtio-net.c:455
>>        #16 0x0000559d6da64863 in qmp_set_link (name=0x559d6f0b83d0 "hostnet1", up=true, errp=0x7ffdd76569f0) at ../net/net.c:1459
>>        #17 0x0000559d6da7226e in net_vhost_user_event (opaque=0x559d6f0b83d0, event=CHR_EVENT_OPENED) at ../net/vhost-user.c:301
>>        #18 0x0000559d6ddc7f63 in chr_be_event (s=0x559d6f2ffea0, event=CHR_EVENT_OPENED) at ../chardev/char.c:62
>>        #19 0x0000559d6ddc7fdc in qemu_chr_be_event (s=0x559d6f2ffea0, event=CHR_EVENT_OPENED) at ../chardev/char.c:82
>>
>> This issue causes guest kernel stop kicking device and traffic stop.
>>
>> Add vhost_started check in virtio_net_handle_tx_bh to fix this wrong
>> VRING_USED_F_NO_NOTIFY set.
>>
>> Signed-off-by: Yajun Wu <yajunw@nvidia.com>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>    hw/net/virtio-net.c | 4 ++++
>>    1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>> index a6ff000cd9..8035e01fdf 100644
>> --- a/hw/net/virtio-net.c
>> +++ b/hw/net/virtio-net.c
>> @@ -2865,6 +2865,10 @@ static void virtio_net_handle_tx_bh(VirtIODevice *vdev, VirtQueue *vq)
>>        VirtIONet *n = VIRTIO_NET(vdev);
>>        VirtIONetQueue *q = &n->vqs[vq2q(virtio_get_queue_index(vq))];
>>
>> +    if (n->vhost_started) {
> Since you mentioned "in a very rare case", maybe use unlikely()?
Ack.
>
>> +        return;
>> +    }
>> +
>>        if (unlikely((n->status & VIRTIO_NET_S_LINK_UP) == 0)) {
>>            virtio_net_drop_tx_queue_data(vdev, vq);
>>            return;

