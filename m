Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00416CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNVl-0004cE-EY; Wed, 24 Jun 2026 09:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcNVk-0004bw-2v
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:19:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcNVh-0004SM-PX
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:19:23 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OANe4x3047220
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 13:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QQ7F+ZEqARvzDlpnQwu/hLNxiy5ZkMCsOaCZdFD1Ons=; b=Roxz5Tm/zPX6xp28
 7wpFQo4vz9FW6ofg7viYgX8f4yn8o0jHTTtMHQS77C0VGE8MUFxN++g2UIeiJdht
 RMTcbaCKOixOk+tErdoITUjivKaHK5JKKylgTAEA3BjwJFxbVniJHJiN+9SXmRZp
 XVIGO9Vshyi4AH7VOP7kz1zF/XkCtA33J/KZOC7y6OeHtMSjRfp/wgUmLJq2qN+A
 pdiK2MmdhbmnzVdlb+Izzgs0hScOluDp1GOt2kRfq69nMy2YXpd8MFuK2S15PXPx
 hEZcLJYwVvqfR1HZ8p9Q3DToxtXc/899hqRLtcDfbI0TQr1/DVZuvyggt34eGT8O
 835vUA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f05ar2cjr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 13:19:18 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-966df3665efso189128241.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782307158; x=1782911958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QQ7F+ZEqARvzDlpnQwu/hLNxiy5ZkMCsOaCZdFD1Ons=;
 b=VD/WZEl42ZKCJ8OIa7Ft1fLWaKOdRNxr0E0xY2tND6RF4c2gk3k8AKGgcbZump0dTB
 XpvCnns8QBTkmN2S+43DvE7rG345gElx+1GZcQ6nFY0iIyka/yqDEDJP/Ubm1DeUThsp
 9CDGql1qQ52aTlDUN7yN0vO+hi2mLx0Yy4aE6oLKnr5g180Ok68OMcl0tpXm/7x8VABE
 bR5tr40xRvy631efTnlNKHKljsnuohyzu3taL96yNtYGq9QdPmnAgS4GKRHbT3TD3Ov7
 28ikZ0Q73q2u8YNMJQr/rPEkym+QP32fIgWRh+RvQdlIJNGYy8ctY2fZWMwjqlWnd7nJ
 sCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782307158; x=1782911958;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QQ7F+ZEqARvzDlpnQwu/hLNxiy5ZkMCsOaCZdFD1Ons=;
 b=NYlnWU0t7fN6qi2b6h4MB91UlXwR9acOKQuU4p7gB+KAqsxEBlVzizElMvd7ubbagZ
 2A2mTMBrw1il+gQi8Yc+yzRgoEs5mtJCrIS9xOLlmTs022bi/lFl+kh2c+iR0y4ndWZN
 7KcM7/GR3XOy32/LJmlobAtGXw8srbrcxYh3tmFdDcd3EYM/0e13V911vJHQkn4hdCs/
 r6FRVe66uyQtYzrJpUZTC1PvTHIKMDgux8jv6LvCj7wcAC98t5FzctDj1Z0Th+sfkeGc
 6UgTGxfuPNwAag0HpRBMaDCPiaOLqQP2q2jaSzaREDoNtdKgW/LgpJyZoBSpMkNauHtx
 j54g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrlPyhvek9DZE8L7R6LHFijOR4UQxkYOc7Dd8zfykntTg2HetidgUuxs3PE/OJ5FwkhwOLK/nnAVWrE@nongnu.org
X-Gm-Message-State: AOJu0Yxg6PIs6BiWGCj028BC4f8CqG1Wf5D6zPnk0xdvCWXKRVvFLIml
 p0nT8YBH/nGsaEKkDDN/Jxkg2Vpc6rAXkRayCeF+ht7OuLK/Hc6+/klwkTdZq+h3LoyWJdSqOjR
 c/wQN5gV+9DtSowjUJP9fIQD+bW+sfZXY22vJ/AQSMD4Kr9ZOKAn7r6uY2g==
X-Gm-Gg: AfdE7cn3zhCnIqu4SgKK7SJ+oPq38ETPSgYeGjiip1AH9gs7Q+KtdcBVk2QlLKA9GPB
 YYs2VM0ojk0ywtPRNEfk+wvUsqJDGjdhhBQ6NKpCuV86jXWPOsGJ0QIKW/+/CMHmSgNVd29Omy0
 f1eL8vDtXWuuVUMuujT0sTYdDsx5d84Y6sJYxZwNv5CMm4gv9rytSduPoFJOtjHdY9p3BgcBZVz
 /l/fte4NJgF5OnMvfaxXCA+0SBl7QKiIyeHnffyWqUbz4oawQ+J/KGExl6TH46m587BhV53gpZA
 gqBRMXPLJnhxMdkKJrIPVjeypZkKh/2exsHMBNyqFHOXCcV6YmHyFvdx8hn0rOAz8ElBPgv8fIp
 6mUrb7OfKa1A1BYod71h/GosJivuluzdlPt6yE2pYKI2R/Y4P0kqfP8HLyAV2Tw==
X-Received: by 2002:a05:6102:4b19:b0:631:81d6:e15c with SMTP id
 ada2fe7eead31-72fd548f5femr3819190137.4.1782307158078; 
 Wed, 24 Jun 2026 06:19:18 -0700 (PDT)
X-Received: by 2002:a05:6102:4b19:b0:631:81d6:e15c with SMTP id
 ada2fe7eead31-72fd548f5femr3819137137.4.1782307157595; 
 Wed, 24 Jun 2026 06:19:17 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c0c610e5280sm671310566b.53.2026.06.24.06.19.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 06:19:16 -0700 (PDT)
Message-ID: <96b2433f-f2ef-4c68-84de-2ef3508d8809@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 15:19:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Record maintainer/reviewer Git Lab handles
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
References: <20260624122936.2706393-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260624122936.2706393-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ewxJold_p_4Zj60tmgPgTZoschU5QFYl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExMCBTYWx0ZWRfX02xLbUuQW/ww
 TsLKxRMw2ClPCqnfMyNzAYMyLjWePemjpLWilPc/z4NiCnkZXUxYistYMsjnIQ8prRNEoUvTjF9
 slnsKUDZj4a5q0qNMyJvS2abcBj9+oE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExMCBTYWx0ZWRfX5Tsph7HT2xNE
 A1VN0gTP4iRUdDexBGyNyNp+cfiEN9cn98kX5iF/8iIt/I6rrTGJY1nUeOfPPedziPMHlH7GvCs
 OgO7tS3ot09UNx32O7ryGx2uwOfdCbI79wYJVjJvgxlNtICK8T/qrJY+cSO5d8eUTcvdVOL/sSJ
 RKWoLnXw6sViY9cczL6DLYldgaXIQYBk15S546zLoNh+2IP59CGxELVlRH3B5unWcsMWzOjkuzC
 r10xynmG2vRGWbshdzP4nCgml2iLsA/dxvsnjJpxES2/SqwLm7cbseaHOxpJAQhl+q4Dp+cpAcr
 BLLFzefOOUsug9OHGb5XoQcWqBvGdSqNHiuYcUzRpSOF1/g9x0RkVOnYhplq+I0D2va74EctrQI
 lSZWlbqLE1ms25Syc5gIy3EE4LuWnw==
X-Proofpoint-GUID: ewxJold_p_4Zj60tmgPgTZoschU5QFYl
X-Authority-Analysis: v=2.4 cv=EuLiaycA c=1 sm=1 tr=0 ts=6a3bd956 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=REwzQqOBAAAA:8 a=EUspDBNiAAAA:8 a=wwC0Tf_8k3USRPEzTx0A:9
 a=m58AqG6LaQXCb49P:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=8XF_WGNd4qQvm41dh321:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240110
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 24/6/26 14:29, Daniel P. BerrangÃ© wrote:
> When triaging GitLab issues, whether regular bugs or security
> disclosures, we need to be able to assign suitable accounts.
> 
> We can only assign Git Lab handles for accounts that are members
> of the QEMU group, or QEMU repository with the "Reporter" role
> or higher.
> 
> Currently one needs to run 'get_maintainer.pl -f <file>' to get
> the maintainer / reviewer names & emails, and then look in the
> GitLab members page to see if there is a match.
> 
> This simplifies that by including the GitLab handle alongside
> the email addresses:
> 
> The GitLab account handle -> real name mapping is stored in
> separate files .gitlab-map-auto & .gitlab-map-manual to avoid
> redundancy in the MAINTAINERS file. The former file is
> auto-generated and catches 99% of the mappings, the latter is
> for manual fixups.
> 
> With this series applied as is, we get the following stats
> 
> $ ./scripts/gitlab-map-check
> Missing GitLab handle: Akihiko Odaki
> Missing GitLab handle: Albert Esteve
> Missing GitLab handle: Alberto Garcia
> Missing GitLab handle: Alejandro Jimenez
> Missing GitLab handle: Aleksandar Rikalo
> Missing GitLab handle: Alessandro Di Federico
> Missing GitLab handle: Alexandre Iooss
> Missing GitLab handle: Alexandre Ratchov
> Missing GitLab handle: Alexey Kardashevskiy
> Missing GitLab handle: Amit Shah
> Missing GitLab handle: Andrew Jeffery
> Missing GitLab handle: Anthony PERARD
> Missing GitLab handle: Anton Johansson
> Missing GitLab handle: Antony Pavlov
> Missing GitLab handle: Ari Sundholm
> Missing GitLab handle: Artyom Tarasenko
> Missing GitLab handle: Aurelien Jarno
> Missing GitLab handle: BALATON Zoltan
> Missing GitLab handle: Ben Chaney
> Missing GitLab handle: Bernhard Beschow
> Missing GitLab handle: Bibo Mao
> Missing GitLab handle: Brad Smith
> Missing GitLab handle: Canokeys.org
> Missing GitLab handle: Chao Liu
> Missing GitLab handle: Chinmay Rath
> Missing GitLab handle: Christoph Muellner
> Missing GitLab handle: Clément Chigot
> Missing GitLab handle: Clément Mathieu--Drif
> Missing GitLab handle: Collin Walling
> Missing GitLab handle: Corey Minyard
> Missing GitLab handle: Darren Kenny
> Missing GitLab handle: Denis V. Lunev
> Missing GitLab handle: Dmitry Fleytman
> Missing GitLab handle: Dmitry Osipenko
> Missing GitLab handle: Dorjoy Chowdhury
> Missing GitLab handle: Doru Blânzeanu
> Missing GitLab handle: Edgar E. Iglesias
> Missing GitLab handle: Elena Ufimtseva
> Missing GitLab handle: Eric Auger
> Missing GitLab handle: Eric Farman
> Missing GitLab handle: Eugenio Pérez
> Missing GitLab handle: Farhan Ali
> Missing GitLab handle: Felipe Balbi
> Missing GitLab handle: Francisco Iglesias
> Missing GitLab handle: Frederic Konrad
> Missing GitLab handle: Gaurav Sharma
> Missing GitLab handle: Gautam Gala
> Missing GitLab handle: Gautam Menghani
> Missing GitLab handle: Giuseppe Lettieri
> Missing GitLab handle: Glenn Miles
> Missing GitLab handle: Gonglei
> Missing GitLab handle: Haixu Cui
> Missing GitLab handle: Halil Pasic
> Missing GitLab handle: Hao Wu
> Missing GitLab handle: Hari Bathini
> Missing GitLab handle: Hendrik Brueckner
> Missing GitLab handle: Hervé Poussineau
> Missing GitLab handle: Hongren (Zenithal) Zheng
> Missing GitLab handle: Huacai Chen
> Missing GitLab handle: Hyman Huang
> Missing GitLab handle: Ilya Dryomov
> Missing GitLab handle: Ilya Leoshkevich
> Missing GitLab handle: Ilya Maximets
> Missing GitLab handle: Jagannathan Raman
> Missing GitLab handle: Jamin Lin
> Missing GitLab handle: Jan Kiszka
> Missing GitLab handle: Jared Rossi
> Missing GitLab handle: Jason Herne
> Missing GitLab handle: Jean-Christophe Dubois
> Missing GitLab handle: Jesper Devantier
> Missing GitLab handle: Jeuk Kim
> Missing GitLab handle: Jiaxun Yang
> Missing GitLab handle: Jiri Pirko
> Missing GitLab handle: Jiri Slaby
> Missing GitLab handle: Joe Komlodi
> Missing GitLab handle: Joel Stanley
> Missing GitLab handle: John Levon
> Missing GitLab handle: Jonathan Cameron
> Missing GitLab handle: Kane Chen
> Missing GitLab handle: Kashyap Chamarthy
> Missing GitLab handle: Keith Busch
> Missing GitLab handle: Kohei Tokunaga
> Missing GitLab handle: Kuan-Wei Chiu
> Missing GitLab handle: Kyle Evans
> Missing GitLab handle: Leif Lindholm
> Missing GitLab handle: Liu Zhiwei
> Missing GitLab handle: LIU Zhiwei
> Missing GitLab handle: Li-Wen Hsu
> Missing GitLab handle: Li Zhijian
> Missing GitLab handle: Luc Michel
> Missing GitLab handle: Lukas Straub
> Missing GitLab handle: Maciej S. Szmigiero
> Missing GitLab handle: Mads Ynddal
> Missing GitLab handle: Magnus Kulke
> Missing GitLab handle: Maksim Davydov
> Missing GitLab handle: Marcelo Tosatti
> Missing GitLab handle: Mark Kanda
> Missing GitLab handle: Markus Armbruster
> Missing GitLab handle: Mathieu Poirier
> Missing GitLab handle: Matthew Rosato
> Missing GitLab handle: Mauro Carvalho Chehab
> Missing GitLab handle: Max Filippov
> Missing GitLab handle: Michael Rolnik
> Missing GitLab handle: Milan Zamazal
> Missing GitLab handle: Nabih Estefan
> Missing GitLab handle: Niek Linnenbank
> Missing GitLab handle: Ninad Palsule
> Missing GitLab handle: Palmer Dabbelt
> Missing GitLab handle: Patrick Leis
> Missing GitLab handle: Paul Durrant
> Missing GitLab handle: Pavel Pisa
> Missing GitLab handle: Pedro Barbuda
> Missing GitLab handle: Peter Lieven
> Missing GitLab handle: Peter Xu
> Missing GitLab handle: Phil Dennis-Jordan
> Missing GitLab handle: Philipp Tomsich
> Missing GitLab handle: Ran Wang
> Missing GitLab handle: Raphael Norwitz
> Missing GitLab handle: Reinoud Zandijk
> Missing GitLab handle: Richard W.M. Jones
> Missing GitLab handle: Roman Bolshakov
> Missing GitLab handle: Sai Pavan Boddu
> Missing GitLab handle: Sairaj Kodilkar
> Missing GitLab handle: Samuel Tardieu
> Missing GitLab handle: Samuel Thibault
> Missing GitLab handle: Sergio Lopez
> Missing GitLab handle: Song Gao
> Missing GitLab handle: Sourabh
> Missing GitLab handle: Sourabh Jain
> Missing GitLab handle: Sriram Yagnaraman
> Missing GitLab handle: Stafford Horne
> Missing GitLab handle: Stefano Stabellini
> Missing GitLab handle: Steven Lee
> Missing GitLab handle: Strahinja Jankovic
> Missing GitLab handle: Subbaraya Sundeep
> Missing GitLab handle: Sunil V L
> Missing GitLab handle: Sven Schnelle
> Missing GitLab handle: Tao Tang
> Missing GitLab handle: Thanos Makatos
> Missing GitLab handle: Titus Rwantare
> Missing GitLab handle: Tomita Moeko
> Missing GitLab handle: Tony Krowiak
> Missing GitLab handle: Troy Lee
> Missing GitLab handle: Tyrone Ting
> Missing GitLab handle: Vikram Garhwal
> Missing GitLab handle: Viktor Prutyanov
> Missing GitLab handle: Vincenzo Maffione
> Missing GitLab handle: Viresh Kumar
> Missing GitLab handle: WANG Xuerui
> Missing GitLab handle: Wei Liu
> Missing GitLab handle: Weiwei Li
> Missing GitLab handle: Xie Yongji
> Missing GitLab handle: Yi Liu
> Missing GitLab handle: Yonggang Luo
> Missing GitLab handle: Yoshinori Sato
> Missing GitLab handle: Yuri Benditovich
> Missing GitLab handle: Zhang Chen
> Missing GitLab handle: Zhao Liu
> Missing GitLab handle: zhenwei pi
> Missing GitLab handle: Zhenzhong Duan
> Missing GitLab handle: Zhuoying Cai
> GitLab handles missing: 161 / present: 57
> 
> Plenty of those will have GitLab accounts, but are simply not members
> of QEMU. Plenty more probably aren't registered with GitLab at all.
> 
> Short of emailing all of those people directly, I don't see a good
> way to identify their GitLab accounts (if any), in order to invite
> them to the QEMU project. I don't want to blindly invite accounts
> which merely have the same name on GitLab as there's too much risk
> of getting a mis-match.
> 
> Changed in v2:
> 
>   - Don't store data in MAINTAINERS file, use a separate mapping
>   - Don't require a --gitlab flag to get_maintainer.pl, always
>     show the handle
>   - Add scripts for updating & analysing the mappings
> 
> Daniel P. Berrangé (2):
>    gitlab: introduce files mapping GitLab accounts to real names
>    get_maintainer: add ability to report Git Lab handle

No clue why Hanna is listed here...

Applying: gitlab: introduce files mapping GitLab accounts to real names
Applying: get_maintainer: add ability to report Git Lab handle
.git/rebase-apply/patch:121: trailing whitespace.
hreitz	Hanna Reitz
warning: 1 line adds whitespace errors.

Anyhow,
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

