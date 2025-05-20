Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67A8C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 07:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHFm-00018n-NS; Tue, 20 May 2025 03:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFk-00018V-8o
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:08 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1uHHFh-000277-Vc
 for qemu-devel@nongnu.org; Tue, 20 May 2025 03:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1747725546; x=1779261546;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qR1dUwKQlhaAn0UeETQeTyHpU+6YPZ7kw0Yoghllxxw=;
 b=DFS84JuRXXReCiXlxcFVqw9UZBhHOlQjQ8LBTxCpXP7nm6Z2Gpz/2+Rq
 eNoAHzsIfZ5/FnZy36UXnTP7JgneHNdO+azQYoD3nMUKD9zG3LUWwYZQU
 HuS/+MNTZdgWCfYJRTb2VIi3S/PPK7OMbJJOCTksv66rpUTJ++TVwyNWU
 8Fuz+nllDVDrUJWMIQMEMcJZhZrwuEt4XBVL7gmyZFqnwlVeF+TSUXS6P
 5GS1KGuf32KWJUX9Kq7LMo+to0uGj2yEF7t7/CKom5MOFpyT46ukXHkOu
 CGRiAUNkW9V6McobxMLrpJkYAe7DY/SRVuRYbZKjhhtwgYBlAbpa1Qg1p A==;
X-CSE-ConnectionGUID: PPJ+kzInTU2vwg5v0u/C/g==
X-CSE-MsgGUID: y4HwkivsQwOyQldRkJk7iw==
X-IronPort-AV: E=Sophos;i="6.15,302,1739833200"; d="scan'208";a="37190742"
X-MGA-submission: =?us-ascii?q?MDGKzA8AWNq5kragAMQcITRWK0mPZ0MaOMLLm+?=
 =?us-ascii?q?T3/enSu1qjpVlEnZlHH5F7wsp98fKI3Y8YUsVZHsKrBNLEVsNB61xA5b?=
 =?us-ascii?q?WQUF+RGIz0zQkNMAXqldbsQj+9pXbcfdbzJZm7C4AAR2ALwQSSMzaeaJ?=
 =?us-ascii?q?cX4YI2DKoQwQFHfY3yhG/yqQ=3D=3D?=
Received: from mail-am6eur05on2078.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([40.107.22.78])
 by smarthost3.eviden.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 20 May 2025 09:19:03 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIyc+lwJ4bWM+G9/S9gEA0o372QwrnaS1YZcfStVAF3rBh+KmuGtucnRi4rpIzIH0zKTWQjyRzGcjAV3HkyDKb1Lpv4CyJ7y3tXdYWuu7jR7r0SvSCROu0hMFnPR6RhyL/GQRwgYKqtr4xgwJ4Eu0bfqK94EXixzPT7J8fP7h0udbaQtprypUUAvOQ75xsnjTF9YxWITWoNXhhnzj7zQXyscrsJDNpAn9grkn8A08OKYGsQ1qH/furfogSStH7DZvQ0Sfl6ExnOSUdsuvcFuNgqatj7QyGFqrnxqEnlxjCTDXevGIH1JL1Q3zWylz/tYEcu3phFV2g6grbtAco4dwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3S3mREt7VjTv0tr9ghmZyu0emfmtqyPz+WGfLtKEs0o=;
 b=wAvopZfA93uZSFFXafBzqYu4n9c2CYlWvw7N6eMde274roowlVdeqxdTtB01J5SM0pdXaUqZgaGiAEKpseAoHmDZdJhS08rHuHxZ0ht4fqXrPzGoEINi5KemyXJ0N0FofGw8V/VMMbtQXTdW3PnCowES4M8OGHa0YmRM27PbOkSvfbaMmOfIrbCCjlWDKIrt9cPUsQES4HN/yvrLhASSPY3E68Mc+nzGuCEnaVHJsQNPD7Hd/KBMYT4IZR7zXcroXZqDk5N07vc4tqDNlpbJflMwl5VS4yZQjPQ7iTBP9mHSmkeRDZhQIFUO4o7xTmiExZDOJOPD74ELw3X5HBDryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3S3mREt7VjTv0tr9ghmZyu0emfmtqyPz+WGfLtKEs0o=;
 b=UN/r0ERKssLSuXafKNVRsLENNZwZ+mOx/C2RleMOGT9NxsHL6vEf/h3zB1LWCfmlCK6/n12fgBhd8pqBz8Jpt8VksrVKOLuIueF9l1rmz/CSnjrcEOalbMkZ0THgYXNX5vy+Qt+s2D49nLTolrEwlkFqcXszwnbbDHUpEfZlRl+2V9UZX/l2Si81fI48u9fjii4qh3hY7MRbvbFNR1nNl/KDKLVaH93zoL6DUPoWoc+a6h+pftdSdiHXZch9/ZVu+kPbWxjkoKK2RmdNmlY6c/ShbTWQktS5EC85QRzwhSjQHdWU61j7msST3ovW3usOs9ZzcUJ9TL+r9kRbk6YKkA==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM0PR07MB6388.eurprd07.prod.outlook.com (2603:10a6:20b:157::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 07:19:00 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 07:18:59 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH 07/11] pci: Add an API to get IOMMU's min page size and
 virtual address width
Thread-Topic: [PATCH 07/11] pci: Add an API to get IOMMU's min page size and
 virtual address width
Thread-Index: AQHbyVd0l0R2Nc6mpkiRSLg4u7mvcQ==
Date: Tue, 20 May 2025 07:18:59 +0000
Message-ID: <20250520071823.764266-8-clement.mathieu--drif@eviden.com>
References: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20250520071823.764266-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM0PR07MB6388:EE_
x-ms-office365-filtering-correlation-id: 445b9aab-afc8-42ec-88cf-08dd976e9748
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?3q/IAIfnSeoi05GGEEeObrmgcSF6jmuvj2G3FFRupAcZMr8/2g1UA+oWBu?=
 =?iso-8859-1?Q?UNIwnYosxQ+lLRZP18E3kxdWTn+69tHq4I3RuQAU/J5lQfS5divGtcCZOK?=
 =?iso-8859-1?Q?3nNHCDdx8NGcXssR1lJehwzgGTtD9SMm8fw68q59M2vGK0HZBiqmzqCNCH?=
 =?iso-8859-1?Q?MOel7XBXFA//xEMSEXbCNZ0n9X6rc5P4/e40Q3XYXfXElBqAYmFdFzhXUt?=
 =?iso-8859-1?Q?nDYucafjR7TDmIaBkbKOGCLoJ3FPQ4jBkhOygE+ALzUDoGRH4VaYnNEzah?=
 =?iso-8859-1?Q?6lK4bdy4xCRHqulk0S92xqPCYspxIzkCojyYWu1F5PVKYbGVlUq+DGbNJa?=
 =?iso-8859-1?Q?vQyPijyQ0i9RFl4OMAmvsyhtIJ8t9FOnFFEbS+uiPbi9NApGzyF/gD4wcN?=
 =?iso-8859-1?Q?2KzrWd9RpnQDyepH4IsVrplhxg54UQyQ+gkUVTp+5DQXEciEG/W4t5Lejq?=
 =?iso-8859-1?Q?eSdjfU6FBsbrxaabolUAPzwApYfxuXr9pNWv0+QS/HsPNuD+i2wH67QFur?=
 =?iso-8859-1?Q?ZlbjFN7K9dZNbbZthc0JO7ktoy338VUcsNLuKgFnUG7NScgO5bWZVNByVP?=
 =?iso-8859-1?Q?6PUQDkB5KqaD0jpggO2nWUujAUq6rMJK0FMRzvZmyW/v1S3O/TX6Sc9h5m?=
 =?iso-8859-1?Q?ugnDHKnACO5XHaXsE9RJzWCer3HfngiCembMXBtvq++JA9K4Q39NOauqxE?=
 =?iso-8859-1?Q?iMd5aXWEVl3R1Ha/IEJdLTFoOFev3FhFSZ5rUlkj7/eyF2jt+ZBhii2vlQ?=
 =?iso-8859-1?Q?UxgtvBht/GS/O5TEVLHECE4e2b4oy0QoGbcJUHfGNSgIWYMZ3bmJYxPkKW?=
 =?iso-8859-1?Q?4YkRohRzgFsRcck8CEj0y73jfR9iBVklfl/Iwdbeg8X4CLI9GlGU2774jA?=
 =?iso-8859-1?Q?cI5CFPnCwNqrBM0cd3tVuXgEQjYUhNsPAZKG0EhYQcQIFnONjG4H+pZrrv?=
 =?iso-8859-1?Q?xfQFCWb3TjttObFtVKpUIPIy8n9idTIPPpl0kQ1FwM3ojZ99eBIhm/tipB?=
 =?iso-8859-1?Q?XCq1pGrU6/025Gz8nfYLe/WhDgJvgQC0ymRHtejsYFCR4gqyZduwOUJ4Px?=
 =?iso-8859-1?Q?PBc+EFZE3NXgqDvQ+5tb/pwMvZpwwsMuxfZ8iFND6ZYIEWnNdHkrrGECSc?=
 =?iso-8859-1?Q?ullABLm6h2RiMPD8KiUuGcXGSm6hYH2CCSE97Nm5W4ApVtPgAEzkOKYLvj?=
 =?iso-8859-1?Q?w7UIQvgCoezb3deVWlYKaKngrbVAn5354W2J+PDagqw+HLEJF4ziOz40dr?=
 =?iso-8859-1?Q?RxcagGFJHJyb5VzEyayuyiJxKgzxqv4vb85dhiQCoO5eSwKztilJ27V5Es?=
 =?iso-8859-1?Q?AcfppxNnDH1RElVqYJf26S6DMPlapCRTa329BA2Yi0WWDh4frDhS8CrS1O?=
 =?iso-8859-1?Q?nisOjz8ECJc61hbRfkVjoqMp9l4DcObWxSnCR+byNlEd+0AFtgECKXafao?=
 =?iso-8859-1?Q?Eprfq+L80wrUld/Cqz1zDddAXNcQQsuASbLoX38SJHh7d55cQwiDl3n3uY?=
 =?iso-8859-1?Q?+LCsZe3Vx1/dGssLed12uYdl6k+fIpR7cnFNAxUkAs5OMbmh/u1NHZq8uJ?=
 =?iso-8859-1?Q?BIa2epE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UqRnR3KYrA6cN6pR0fzoL7gTXF/9tqYwgFis47nYEyIEu+8Mwbzvlc6XzT?=
 =?iso-8859-1?Q?Dqf2I5O1BX8o5TOWwb6Lam2G33F0uaT381OxwS1F2m9nU2HKcnqhfP83zl?=
 =?iso-8859-1?Q?ngeyTe1QKL2fUV8nys66PaEwU8IiGLwQ+ZZiwolrw/pXPpBi937z7GuGi1?=
 =?iso-8859-1?Q?GeN78TCwC53sVbSGhckhhO7BTlCepf3jgeS1rhzExcZCny2gJENFEGisBv?=
 =?iso-8859-1?Q?ujZYKYaosJMeoBzrWj7zITFL2udbUWoYbORkyEtOcL74jFrBhcmF7hfzKe?=
 =?iso-8859-1?Q?WKIzqDjJ8skb0d4COJlGtSnYHny8yEhxxzXl/bS7lievth2dO3VPaUdWQZ?=
 =?iso-8859-1?Q?SS9ooULFR6zNjmY0AxYbXvFUWuWQGR8i38VMZ6XqwlkF2IkH11Mk8ZsHmb?=
 =?iso-8859-1?Q?mpA0mgVfYikP+zFpqPAKeft9HoqmMUCQ/pJ1ND/8rIyCuj6iW7PzPqLB72?=
 =?iso-8859-1?Q?tcZ9XqWyyHFqpdMhJ3Apbs73B0uSeNVa261ynEyPL2e+vcrPiO/vHLBfs9?=
 =?iso-8859-1?Q?F40QDwGBTCzg9M66JGkLHyon4rxgh2HLwWzaDlXCNVBCfKWZrbqgKDCHOx?=
 =?iso-8859-1?Q?5v99AY+uim799IXm5aS+6kNdHF4dW4mTevOhj0TqiAktl4xrmTHmTHH6gv?=
 =?iso-8859-1?Q?yorO1+qbpIFr0ZMwFo1qXEhNsNf04aOBBYd1CXMCYa6OVeq6Sg2l6iDzua?=
 =?iso-8859-1?Q?e1zz3VYHmR962sWPwHC5iR90zRe0/WbYbhFk1PwpKBUcjtHNim3XGd28st?=
 =?iso-8859-1?Q?udQUHoRaZavJtun1WNXVxKUUua1yWtSsTzPGl5Ihu8D/tboaYoevnySkEC?=
 =?iso-8859-1?Q?5liTKIAbClaF0wN0mxzabrfLT8oUNvTzAU3QKf0ZvBPifXZZbjthLiYvmY?=
 =?iso-8859-1?Q?TvaraP/lX147rEyNg98CzFQ8/nurEdOr+iK+mQO36TeVm9taYDuLbUu2mZ?=
 =?iso-8859-1?Q?fZHSZuOOEx6LkvQixIo0H27BU0Dj6BkhsWuNatR92OuHbNWtMnuKneyfC6?=
 =?iso-8859-1?Q?gOCZcY6fN/NeXb7uCK4AcIKWhvxet4AsrFXsu8rXxJqIeWFIhh3ehu7W/J?=
 =?iso-8859-1?Q?ZB5Vv+AIIQBj7NgUuhh6/btaADzRWjJRFrk/+NQDwgLkwgvkKQfcxN6wWV?=
 =?iso-8859-1?Q?JusozGU+ZHm6gRbx8vSlGmu02L0ho0kA9CvzswoUvuoDjGgzNL/vKAwAPl?=
 =?iso-8859-1?Q?9uzJSIBraJVXUh4WtwbxMBOHWYnMhx2ibCR7kBjj3K8sfH8FMZEdwWsueK?=
 =?iso-8859-1?Q?MDNeMKominLYgjldf46d2fobkJkjHKfs68I59h2UXPZbG0737s57ZMLWu8?=
 =?iso-8859-1?Q?3lD6FquYkVBaJS+IQVMJDC27M8JJf1YpBDxEOfnxa8MD1C/czLceIaBgj+?=
 =?iso-8859-1?Q?aXvBCfdwBMyeblEmWo46G4wO4LysSFlhBmG6lkeuyWCugmmFCyQSts1q74?=
 =?iso-8859-1?Q?mOSjO1iNoj5R+W3/WFk5M7pPypcA+cp+Mt3SMKQMnUOVR06wzrrj8Jt8ji?=
 =?iso-8859-1?Q?vE0kwQH84XVUesEq//k+4naMWx454B8t7BELJp+cJpell2ij18DMZcm38v?=
 =?iso-8859-1?Q?1eJv1lBoNKONYRZFBeXbV/thJVx92gSgpO2dEXvYVwms+c3A+mSanCX8dj?=
 =?iso-8859-1?Q?RuCVga9ax1RWDVM4Kqs1hOTchE1dnMo1Qrrhm3hN1qeOK9CrsTBUIKrX9b?=
 =?iso-8859-1?Q?GIKt1eZxXn2uDhL1zFA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 445b9aab-afc8-42ec-88cf-08dd976e9748
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 07:18:59.6214 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OsGcWBW5DGnITqN6ff/bOixMtBRvY63iQvqz8Fr+j5dg9ORq6SSMj2LYcjTlYFRbxjRr3xZB7MVnMbX/LFbn6uf2pfqduZYfZiR7cPqxRFaebDUjlFG34t4raKwbo5Bm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6388
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This kind of information is needed by devices implementing ATS in order
to initialize their translation cache.

Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
---
 hw/pci/pci.c         | 17 +++++++++++++++++
 include/hw/pci/pci.h | 26 ++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1114ba8529..fc4954ac81 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2970,6 +2970,23 @@ void pci_device_unset_iommu_device(PCIDevice *dev)
     }
 }
=20
+int pci_iommu_get_iotlb_info(PCIDevice *dev, uint8_t *addr_width,
+                             uint32_t *min_page_size)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &bus, &iommu_bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->get_iotlb_info) {
+        iommu_bus->iommu_ops->get_iotlb_info(iommu_bus->iommu_opaque,
+                                             addr_width, min_page_size);
+        return 0;
+    }
+
+    return -ENODEV;
+}
+
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
 {
     /*
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index c2fe6caa2c..d67ffe12db 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -429,6 +429,19 @@ typedef struct PCIIOMMUOps {
      * @devfn: device and function number of the PCI device.
      */
     void (*unset_iommu_device)(PCIBus *bus, void *opaque, int devfn);
+    /**
+     * @get_iotlb_info: get properties required to initialize a device IOT=
LB.
+     *
+     * Callback required if devices are allowed to cache translations.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @addr_width: the address width of the IOMMU (output parameter).
+     *
+     * @min_page_size: the page size of the IOMMU (output parameter).
+     */
+    void (*get_iotlb_info)(void *opaque, uint8_t *addr_width,
+                           uint32_t *min_page_size);
 } PCIIOMMUOps;
=20
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
@@ -436,6 +449,19 @@ bool pci_device_set_iommu_device(PCIDevice *dev, HostI=
OMMUDevice *hiod,
                                  Error **errp);
 void pci_device_unset_iommu_device(PCIDevice *dev);
=20
+/**
+ * pci_iommu_get_iotlb_info: get properties required to initialize a
+ * device IOTLB.
+ *
+ * Returns 0 on success, or a negative errno otherwise.
+ *
+ * @dev: the device that wants to get the information.
+ * @addr_width: the address width of the IOMMU (output parameter).
+ * @min_page_size: the page size of the IOMMU (output parameter).
+ */
+int pci_iommu_get_iotlb_info(PCIDevice *dev, uint8_t *addr_width,
+                             uint32_t *min_page_size);
+
 /**
  * pci_setup_iommu: Initialize specific IOMMU handlers for a PCIBus
  *
--=20
2.49.0

