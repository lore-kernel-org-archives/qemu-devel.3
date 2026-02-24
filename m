Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88DCF3C9A8
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuvBp-0002TA-OL; Tue, 24 Feb 2026 11:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vuvBh-0002Po-Hk
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:23:07 -0500
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vuvBf-0005It-Qy
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 11:23:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aannFkzJZaJdUp3n5yzNLxI+8JoX0njVS+rqNl8PIeY2ZsEZCB+RRFV9LvRWTo1ZlK9h0zOfM7UVj5avm0EytMe9wrtbvd+ngAAhoPTrw2ouRS9B9XK2rI1FzZtGwWeLHsdWMVpOFUS6ZdJgZ7azN1nYUO8qkZ0kzX0lpeaevIk+W9doEUdfpuzLvacl7Lo7xA1b6vSEeG3zvSBzzQcRg1vByC4OJdLP4CuRf5wJZ39ng8oVN8vdjZKkWb4q1qn7T3pjOu+YI+BV9adKuKqxvXj5ncNouzAsSsg53iLEP3g3DrcGA+RWFlbi8Y/3z9dEYRy6focJ8fldshIK6/ZmeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rx2T/M2lRm+cqNT/n6XDGGmwxhIXUg+8/iay9rWHBM=;
 b=y4n2dYth6s5/5J4LI4eb5eXu4KMEYKV70rIifH+GLdd85R87WoF17zDqtX40NKnmW8AcQffA9peWGlOFkJZ2MW4VIp/P0IRzqeU0R3iczwCVk3pEk56nKyqgZW/zxL/PaeIJRdpUmQxVQvO+4847vbS77Ey4EPJIhN//AkXhb8Ruv8VoVKtY3h2qz6WUGWzHe1ngRAUD4OcM1dUJya3YuTAw8kSV8hmnmVhbpC3rsg3mwIceFlZ+sw1QT87ZWLROSnXClJe1s60yFmJKepL6duMKmZCZ4Ldb0kN92bMnUUwT92AOisn3xZ/Hm03AHdiK/m6NmRumy1uVWQWG3WT29w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rx2T/M2lRm+cqNT/n6XDGGmwxhIXUg+8/iay9rWHBM=;
 b=dUfutA6gvxPrgCyoah78fFjX/D03WIyJU12VZI/NaY81hGVZgUGA7lruwXiruGl0sR5ccaxXJxCRLqIf0DwDhd10noYjcHrlesZpBGuLKBsyeot9/BN4kXt3VcK2AgawOrPDDu70hzkRZanbqIAC2T5nT/v6/H7lEnEx9fVMVXhF5wjSETcGwXr2Sk8EcDJI+xmCZC+IGUm2umVmAZEQJfDWNyBlKhVKTaoM4fDmeeSojwQD/h07P3W3enGM/ZUi/xbqIKKOP++8GzyNAF1zpceX5eKQVHfIlw/SbgKaSC3yedrxw/zeyRU+NyTyoyTJNz7IO2n5W4aitnzVO4v6lQ==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 16:22:57 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::928c:89d8:e8d6:72dd%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 16:22:56 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <jonathan.cameron@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Vikram
 Sethi <vsethi@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "alex@shazbot.org" <alex@shazbot.org>, "anisinha@redhat.com"
 <anisinha@redhat.com>, Aniket Agashe <aniketa@nvidia.com>, Neo Jia
 <cjia@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>, "Tarun Gupta
 (SW-GPU)" <targupta@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Thread-Topic: [PATCH v1 1/1] hw/acpi/pci.c: preserve generic initiator
 insertion order
Thread-Index: AQHco6Ae/zryn4xgMk+gEkicK+J837WP5KQAgAAFPZaAACDLgIAAGNMAgAG+fwCAAALoAIAAC4SAgAABXiqAAAMiAIAAAQym
Date: Tue, 24 Feb 2026 16:22:56 +0000
Message-ID: <SA1PR12MB71991611FEAA1B2D6A5171DFB074A@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20260222020812.26475-1-ankita@nvidia.com>
 <20260223082804.0d293861@imammedo>
 <SA1PR12MB7199F0C2E1D2325B0062B004B077A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <20260223104411.57a815fa@imammedo> <20260223111302.00000081@huawei.com>
 <aZ2sylCydE9Js1ec@nvidia.com> <20260224085955-mutt-send-email-mst@kernel.org>
 <aZ2449e8ucB8e3AJ@nvidia.com>
 <SA1PR12MB7199847A879D66527B03DB1CB074A@SA1PR12MB7199.namprd12.prod.outlook.com>
 <aZ28qvehl7Lleo2a@nvidia.com>
In-Reply-To: <aZ28qvehl7Lleo2a@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|BL1PR12MB5970:EE_
x-ms-office365-filtering-correlation-id: 2dbe2d41-37fa-42ea-1eb5-08de73c0f81c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?F4lhkKY1S2SojI4wYdezKeV4sB1JboNnNz5BcqKssd/7tUTN6Ksp/eQAQq?=
 =?iso-8859-1?Q?WpkHbGUVuG+xARlqgV+N7tgjmrd0hJw9lIvJ7Z5ASk7vRJ3eN7wzKrDhu3?=
 =?iso-8859-1?Q?K6dor/mpqFsjP/aKr9O9uQ2qT4WTKZ3KY1zlzqNRjqjx+OTaWyz/5LCaA8?=
 =?iso-8859-1?Q?/PyobAMjypqBeDB1zY7IEPsLddHlKX6v60DDD7Oj69+gseo2LWYdPaJa0x?=
 =?iso-8859-1?Q?TbpdQ0lDlFcZmQHE2g40KjJGLwKKGfr1xHsOuZ329UvH9uObw1zk55n9/0?=
 =?iso-8859-1?Q?8n09AxSgGLxx3g8Tk3LdXWvaQjRp1EM1gcJF0obzzh1uHxGucNQcNTcytn?=
 =?iso-8859-1?Q?rKzA7ZN/e436g9xRwn6KWO9t9+08B2aaE5cy3BpXywJ+8/qzj6hktnaUub?=
 =?iso-8859-1?Q?PH0k/4J20ofE9tLVMeZXlPGwnGM5WoPyEcE5RGQtYTGIoNS8KnAB8Q8bbn?=
 =?iso-8859-1?Q?w7KvUQ9d8C2eGPXWBTD3Zk48OS/FigX/tp1MtXtKIniafwegEZT2Gdj6tk?=
 =?iso-8859-1?Q?0j3OLZ2XihMp2WMvK/09jjcvsPXsvu3+fsVh0Nv2vhuNEcDVKKtsVgfQS7?=
 =?iso-8859-1?Q?7/9u0tvrUlqlNcWH01XSFVqFMTPjYSfo8p1WdnrYStip6bOVGOZXsH1XAD?=
 =?iso-8859-1?Q?+orVSa9FPuPk5Y01skOvV/E9milIy7AsJ59OXGT+caGNcQ78V7MkohXwho?=
 =?iso-8859-1?Q?T/pPteEZ444hJTwYf/0SqgirZzMiG0slP12SudwSI+KNrIv7X4YdWA9EQI?=
 =?iso-8859-1?Q?nOZGAYxnGsz+luDPYf/5q+ruNf52n2zaIMq/vwJpd7cah/RIZrwOyXWPjd?=
 =?iso-8859-1?Q?7kQFoUbWAs7rOP9lRnichJ1wBbASnjGOlkNQoZHVN76Hlx3LpLC25TRA2z?=
 =?iso-8859-1?Q?5j9zPRu5KDVuTQIuPvTqFT+aKd7rMjCryIu4kp/AqpIR3TRJhSIhK9pQ3O?=
 =?iso-8859-1?Q?vc5JEiJ6CHetZ0ouCqhdzVoVufgZIbP+50a5Mz5KuKZHXH3dqXtDydJDNr?=
 =?iso-8859-1?Q?N5UsfhUF6TlyBb4viempvDvawsGmFKGFKrK4+ZerygaKqfnvrwZKWbaRHW?=
 =?iso-8859-1?Q?zsg7E6T2/3IuvJehlENVDu1Af6XUJ0ZPU3AKFha8jhXUGYLhTUBsVSiIoU?=
 =?iso-8859-1?Q?0gbCD0gxmk8xuXn8MThhiZ0TlHxNNXokhwS9b5wlrhfyhitk8XeTHTINai?=
 =?iso-8859-1?Q?fmGtfeQfgPYka/b0ZmT/SxDs/ppf6jAsiAdopAW1CjpzKYW2tt0FE7qLbi?=
 =?iso-8859-1?Q?g0Ym4kRC3QrRb0uF+QBbR+596rwIbRw5L+KeEsRce9FPW2+TETFxe9QYoz?=
 =?iso-8859-1?Q?U9xjy4k2eCopfNo3p6IEfmgRtUMTTjSqtD0a76RJDS0yEJmN9Tf/l7MPyq?=
 =?iso-8859-1?Q?McAdhoDqIi+tGlUqScW7qYP8nVUlDRPNNd2uRM6kc0CKrCk+mGQalDKQO5?=
 =?iso-8859-1?Q?awAXe0Ij7odfsedVBrDGCLxKoSSPPzzO0XdbGMyYF6FKSoakHDqmcKg+43?=
 =?iso-8859-1?Q?QvEagwhgiJiaY0GdHCxX8ZBNQ+m/LNCksegs84iuPkYnaLAUKNX2ZrUn4e?=
 =?iso-8859-1?Q?iAq2532ZAJ5bIeV9zN8cFRwV/ZbC+CwLminFSEMZDCxbPp5xbJ1bMjitks?=
 =?iso-8859-1?Q?uligRquyKDiXhOntW+OTX7okfSJh7OmITi?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB7199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PofPaLre/JGMKVB5iQA7Mm0x9j4H05tH9ik3XQottD8kDig3tTqKNepvvl?=
 =?iso-8859-1?Q?0T8LWQGwwN/NtYQYNp8aMneTq4/rhDYEWrtoQT6yaUjfD78RZ1X6/lmnTF?=
 =?iso-8859-1?Q?o10Mbd8lsOvTyEQT0UXXM9If5Jv8uF7LuU9HiqMNEUXQ5FFK1ZsAsKCCWb?=
 =?iso-8859-1?Q?UEQzb7D5ol5c+gUmraPisVeSzwhFBxyOlvk7zjMxQXloBhcWzRvovXqiO9?=
 =?iso-8859-1?Q?9thKsb3EV8y2kNs6JHzJD18dphKXpdDKPdHPdO1VGb/DlLiHumbew+Z7MU?=
 =?iso-8859-1?Q?IzxVUKA2RD1p+eiEL5lI7CymdNqN5SnJcO5+OJfRA2GOB2tTUcLKjiwEsp?=
 =?iso-8859-1?Q?xBekfZMJyx21hsk8YXo7Lh0jVUAV69Sf1zX1erdV4E0dlxwS6VRelGLRmX?=
 =?iso-8859-1?Q?rLGi1NKP/VLGVRCFUFFmSSD5/+MM4Kn1A1l92OnoApHWMSNd3pgGsjel/k?=
 =?iso-8859-1?Q?iivtjucHq1Y2iXGiVXrwU6lt8ZkgRK2BT624lVu0xrgt3Zbde4CPo3FxLo?=
 =?iso-8859-1?Q?sxTH9za4zekozxtBPY/xeNjqg4zL2xqnaoy+m4frPykeNreZp9Z9gFO6Pa?=
 =?iso-8859-1?Q?kJ1YGxboVmDBSieT9/45HBYgWxaq0WI21DtQXBJ2IZbrySMf63NuMlVrSO?=
 =?iso-8859-1?Q?iopHOjG4M/tAcHk1dQcWrrBMSEs9VBohXL2ADMYUse4YQxFYk4WTFOLTYS?=
 =?iso-8859-1?Q?GuFQA5lhlxVPPhrfZjrEa3K9pXBtvvlYcbvDOi6f8Q/QUhCWRUeiyHIJPY?=
 =?iso-8859-1?Q?jTINGnVgm97JjXWa7gun2QADqapgHnhggSvUsLmQyRQVEu06b7RB5i+KK4?=
 =?iso-8859-1?Q?J7IkZteka4j89AP0rMWa5serjghakt4U2aRh154Efa6XERhPxrQYVKdSCw?=
 =?iso-8859-1?Q?tvHgaJJWAPlPzkv2uI9p1b5fRITx+Um9M+jdYxdU+AYkX2BI1Y2tWAEufA?=
 =?iso-8859-1?Q?LlZVEjgUXWX1hkSZbexoaBHqReWn71r9yc4kfYfVqlqcdPsadJ/dVQYzHz?=
 =?iso-8859-1?Q?c3BsvFUMdi/hUkgR2Q3p1pPW3duQdhfQPVEixqPlKR2wnKMuQ4qtp1iO3t?=
 =?iso-8859-1?Q?EP8qESlOzSbpXaTVsD9QGTQwT6U/EN0KoIE5KWpyU4wzyV0OMJlo0ssL1F?=
 =?iso-8859-1?Q?QdS8cQopm+hNas+wf5uoySzfzk+ZWlTxA9hksJE+FylLqRZ/b3EMYXDNuJ?=
 =?iso-8859-1?Q?Du7TxLXenXB0C+hyMW6B4+S5YDh2GxS2yiunafglFxCzH/5gIQ6nt3bebH?=
 =?iso-8859-1?Q?3DW1WmB/pe2QziQ8UbHWWszdoBV2Y1QWo0zqwFY3l2Pq6DOkzVi4Sn2CkT?=
 =?iso-8859-1?Q?w0UGmA+PGlHQBNNcoi/K/8H58Sheks0qLZ9jAB+KU78ifqFhKH7d3GWUPA?=
 =?iso-8859-1?Q?mI2j7NTkrNbU5AHiUINzq7orDUR2Qdpoy0jxVmktmBaD0jsztJh//QFnJP?=
 =?iso-8859-1?Q?PNBvXr7/jDmwglLkTLKZMkqq3KIKfxuYx9RbiBMCHCuiTpEEuG1u9kp0Vu?=
 =?iso-8859-1?Q?lyA93UIvQjpqEJ3THTEBAf3ovxIfxjtQmhZBlcUcdxp5fcsaQiWBDvKCuc?=
 =?iso-8859-1?Q?Msmhmxq+vYaRp7JKEhUb/CZfiPs8rX/OlUq15ZW1TRz3Wejrfqp1rYAddT?=
 =?iso-8859-1?Q?FcPkDR0m/Y/71+W1y03vpC2sBkhQdVGEF4RF/5v+KV5W4kSKtfqfDVI9im?=
 =?iso-8859-1?Q?vCpn5iy2UC0fIiwTYNkwYs9v6gMgu0qoY4xiY1YtuaEwlGnyFuAXQTFP81?=
 =?iso-8859-1?Q?TjO6niMg54X2nLAAXsTYx44EqGh858uRHA+uuekBUvxQ48?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dbe2d41-37fa-42ea-1eb5-08de73c0f81c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 16:22:56.6232 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MxhFqE9BAp6T2LzdXO7EBAL298h9wi6tFyMBPaKGof8P1rilHfxslsv9Kos7dqB0IInfeZOcwykwi+M1I4ea6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=ankita@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

>> Now the kernel parse it in the sequence of their occurrence. A jumbled u=
p=0A=
>> sequence thus results in a jumbled up assignment.=0A=
>=0A=
> But what is the actual failure mode here? So the numa IDs are all in a=0A=
> weird order, what goes wrong from that?=0A=
=0A=
This interferes with the ability to replicate the numa distance topology=0A=
on host in the VM through qemu command line.=0A=
=0A=
E.g. consider a NUMA system with 2 sockets each with a GPU.=0A=
0,1 are the node ids for the sysmem on socket 0,1 respectively and=0A=
2,3 are the node ids for the GPU memory on socket 0,1 respectively=0A=
dist(0,2) =3D X=0A=
dist(0,3) =3D Y=0A=
=0A=
If we try to replicate this for the VM by passing qemu arguments with=0A=
4 numa nodes and assign numa distances similar to host, and for the=0A=
sake of example qemu mixes up by putting GI for 3 over 2. The SLIT=0A=
which sets up the distances do it considering the original order in the=0A=
qemu command line.=0A=
https://github.com/qemu/qemu/blob/stable-10.2/hw/acpi/aml-build.c#L2040=0A=
=0A=
This would lead to a different numa config in terms of distance within=0A=
the VM that the one intended through the qemu command line.=0A=
=0A=
Thanks=0A=
Ankit Agrawal=

