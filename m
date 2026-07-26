Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49422C53200
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 13:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnyjh-0007wk-B8; Sun, 26 Jul 2026 09:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wnyjd-0007ts-H8
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 09:17:41 -0400
Received: from mout.gmx.net ([212.227.15.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1wnyja-0002jH-Ml
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 09:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1785071854; x=1785676654; i=deller@gmx.de;
 bh=BuWD1Xqmg+BSegWG5VREKc4KOKkmdNgEwruhBxxyY5w=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=F71jijKwKHdyi7S9GKtWisED00oNYQCGeJizN2UqVgFGrNCZ88AJaTmbhnSvj+3f
 f34kaiyrqyQUKyv248u1jMgubFesdMHNcLHTR+Jdkg5MihmjSPulU5T9xoqqzjE9t
 HA+oGxPBB4uD4dU8pfXBnIsqAS30KLXGbp7v8UCNy6g16agiOxcycdxu1YxJaYV01
 8cq2t1Hb1MtkT13VjbYcXx1rh1lDDKLIyjIdOlkm+H/CHfNpfv2i/VRcbxMJvK2gQ
 XKexMV70s15zVIrGeQH6fqhGwugy72dYUjDDWYvaCdkB6PE5ujvwaE33lAYIUU70O
 WLLp0iTpp8N2UB4YGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2V0H-1wxqEc3fcl-00xuHs; Sun, 26
 Jul 2026 15:17:33 +0200
Message-ID: <18f6f24c-4324-4883-aba2-9c4470514f29@gmx.de>
Date: Sun, 26 Jul 2026 15:17:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix incorrect msg_l[sr]pid members of
 target_msqid_ds
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 no92 <leo@managarm.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20260724160105.3787888-1-leo@managarm.org>
 <9c278046-3b5a-4d0b-ac55-76a304f1109a@oss.qualcomm.com>
 <a0adc88a-4405-46cc-b46c-6981f310db8f@gmx.de>
 <0207e5f3-3029-4f14-81ed-fb469a02e6fe@oss.qualcomm.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <0207e5f3-3029-4f14-81ed-fb469a02e6fe@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gUwQXjBiL5lSV9xSW1ejtp7L0CyoGy4t5zHNuYhnNa8tnmzZ17C
 eWRo29lywbhT4yfC/BXgUeAt5zG3Mw0/PPfGhWi/I6fK9ECL8NL4NGjJCxf86Od/WOL+SZX
 aGu4JRqaLzI9BQ5uw3Q9FYpVXsQEgS8+UiyZRD0ME4ohTHN/OpxmLfz5UGOUvv7Hlsif/F6
 yTLQNS3TQ3lGBX//cQaDQ==
UI-OutboundReport: notjunk:1;M01:P0:3a/0g1jRoGU=;0Ce2q5Eiw+bmnk6PqZRreFGqGAl
 exPtGYZ5ccq8a3yzcbTx+6GBqbkUKphVJznRaJkJ9m/Y585SbCLWaTsJeyJNglDqdze75CGLs
 4oCke0h7kabmCA3qpORBa7h58ANQQ+zKIIitQnJqY77QNQiYrMN7jttXTtFOZsANqqI0iaw38
 VVtzaiT6fMTVCdk2efj+wJwkXmS5vZ3gArFV9cKt3J9jb0+WZgycfdt53UTiWsHq2HWT16SCC
 n/JUSlw3xioAjIKLyVLL0z9zTd2jPnlzdP9lhjuwhIIuT296wASTFTboc1LnGbOa8y1IwQ08o
 bHsb9qS9MIlhTfM4o2T14I819eNDfbf7zhbsGz7CRcdrN5mxMJ0ugJKEDUKONv8SwbKNc6Qzm
 54gB6yPzzzij/dOgCRaIXLm2RW8CziYla+sm7/DArDhwlnez2OkcKebazeOt/ynkoKewELvSK
 KufsTKIJQHIBf5t9q93GnK7qJeNHbjmDluSh1BtyffECWYQTVlJ7obhHZtK5I7HKN49ru5FQl
 ZyimjyJvR7LeKEAgAkEybS0oCNvzyHMEnMeRlXgj6Q3iSxTw3MNR2gbIUTK9vctXIq+gihV23
 dSVCEJ9hvPKBTMCKSw17F3yYcotccuA4bXzXwIH/m+MWkYQqfD4Brecjwk1q1gFCa8YTev5Al
 toCJQy1xxkg+SzqDYq3cTyn70idKrLjt6UG+XCeufGS2r+wS/2uC/+9ABujaFSJPwHFUejNfy
 +MIGGphxWWRuzbkb7PuX7wXwOciFfkgvCcTN+cE7aK3lIO5GqH3MNPk4Ytf+CcFYYrM3Nk7HX
 9U/ARQmfE6LjGeeQLR7BybIwCrzVogfuIzaKiBHHYELoqVOIbgjVVadKtvSyWgZr/ez0zTpT2
 Y19W7gYG9RrLTpAxKjhX31P47UWuATynBk7oO0JZ6aWwmTRk4WfNMozOKJ7mnBxlBEO9pKjZ8
 4MqlmnBKw6hnDPDcZLdStNXTTkm205KfffuqpcLgnql8t92/UsGInmnuQYzYdrydgX2Oruue3
 o57fMe4FC3Wrr30Gs2z/asIVu5hnvqYwy9/7If4gvgVrVAqouMFyPso/J5kRQFOg1hkUOrl9H
 zcZVTvWIVLF0TTmdBKDOqbCUWM4TNPiZPtkbVCm1YfjQlYQs17cRb2s2WPWaXpF74nFbbP/ub
 rLa1Y4sckETncL6qPjccawT0nPjDc4/Attdt2mEkFEHcwTM1NFg89nn5gKKksbjfcfvv/dISc
 DVZlMtFx+avK5X4hT5BA7dNoG9wSH1kA//CNVSHe2SeDSBwRIGgP32UNXo+wTASRxles9+IUM
 hI4z3l8B3F/W6BfDgofhwk/Z2ElXsO9kEiPscIEgWTqjw+7kkniz90GN5pvmRk3Mq3phQGtn5
 P8g0S9oaj/VwRv+EkZuNAdsdXjbphYA7jGBin1U3Myc1Hz/xQQ4mPomYjfZKuAXmc6zP0foOL
 RSHLTBVMqm9zSHqNIjFsoEgZ3NfhoXghQDdoFRHoOH4Ki8soeW4vTFBY70AO9eHchzEo5yqpy
 o3VI6rL0wxdqqjGkpG0O+v052SlztqReIsYfq0au7RAMwOTdPyWrXpb6dbhgPI387b7Rf9TwX
 6xUorZH0R5OR4bf4m0J+3x872v3/AOs2XPb/PcaPQkcWjFBfzJLda27zlDFVhnMgIA0nJ8fB5
 F9vtD5RUmombrNa4nwQO0Zgkos5ywA1j9D7LPo5UFaPJi1t7UBfWWLEM8N0JwgNHpJnmEbwYV
 8DFew0QMoDrgBxPdU7idHpS/CnsXlaYGK6TmRi3XJ+qUJOaGYblwe6jN1Zvp4jO9FkgQ6M2Yg
 AXLyFcEo4kzD7QKinxcgxLQzMCbRXNIT39+rUr6KeghH3KY/tA9q7snzQHC2Xu4pw9n5MZ8/H
 6a6f6BSxwuPuAd/H0nVXzn1rGlgxWPO7sYvpAcXBJG6j4pz0YUL3CE38XI3pzx5pUIM6scgJj
 ulQTozDmqYaRu/kM5bK1ZrZ/ADvOhhrkVYbVXSq2ytyK4SlRfJ8eJStS6iRaTfr7/hBfksC6e
 BXQ2g02Udk1fOHgTrc+rLR86DnFTHKDW+CJn43OqOxX0ibapNPWjLn3mFoXD2AMR95JdM43cz
 IU1gxIPyHLV7N3MjnFzZNR+UepGXqhnYVqgRnmMrlgUHHmmNFbDHMy//MAL1tT/KTqhKWFM1/
 bjmB5HuOVaoyinE2pBqDgLBNqjKrCk9nedIh2PzRv/TV8GA6flrwTnC8Nd/JRFRRClCvcoTgx
 jQ5oG1TRzctIJEUE1TJ2BL6xWp6mGURTRqhRVQj4wyDBiVFv697xQG22vZUdR01ggAW9K/o2Q
 QN3BlvO+8owujR7YNe9k/6UkwFI0o9GK2AlWVTgBUuH3eV/c7kAuV+2te+OkzzWx3RypVlhFf
 w8rlIxs1Ebr1l5aM49Fxt6wShkNKKRU2x0C5ne7g9wIzvMELBf5DhOs7tco3YvkG5RG8Q+Iz5
 A0u2o1wJ5ipBqnpuR8wMObrYWPm1EtgOypz+gae4nZqzFxaAi2vMJXQbtF6dYWfIz9LCNyboJ
 TbnV2UEECEGFpvjpCDK2AuzMeni4dg5xUd4AjFglByaTkbIEZgVm0pru4j0m5z2qLEm18pRHf
 EPK9X3JtpwbGRs98oK7zqaqRZPGZFhacMKYmOv0gEb/QKD33Ir9v+AssabUfU5D33WHkx8XwC
 ttbGGg30FVX+Hy2RkmFadKdVEAXzjXmLjAPxElf0wQ8hOa/59q2jVNPMdfDhfZWkHIiJ9BFen
 uaOueJK59r0ki3VBwruT/bb4ig5hCZgzihCQpTru5nGhjmewJRV2qkGZNaNaHtaRd9q+ZTm4I
 urh6nYRh5yfjY6kfcBLqFDN7PCRjgkI+xoXXzhaNuX6MvnIPykz4lKBcYLcoQ7gZsQLM00RpF
 fExqQvqcTmzTXhjMoWIQXybRt49H5MopSf12fjPwdzMKNqaXhtXhJXES1J+uSMTqVQyCnVsaT
 A4jzkvTzjUr379QNpqMEapHdjd/1YZHfPGp6TLI7QNT3PMVBdjyjQ6FmIlYLnxLNNJTsgoVIy
 77lLQ3UxyhDpOFWEp1XlFwhnUsFxcxXbi+zJa5hAoT0FW20CLXSXTpGjkTnXSrjToFKCMmwn+
 wWxgLAJyDuyw/X8JfYHbW27OkpYrUtNRp3p1SBeGqQDZoyTIG1CftDzLKUniuSKaT6Kyj2S6+
 XaUqxxATT2JFclyCMCUQk/844SS2xWTlBY6JoND9+7qUUpO0uWdd7DInn0G/ue4P2kde/+s3A
 j9oY45cYmWrmxIgTdFlmFHExenS92igfmZeGe/dYVjWPP10gt3o2WTLpEYWU2lG908bQmRxiS
 IoTmBxm/zMhlfwz3wNuXC4F08oVk227qnpIsLJLXv477h7NAlhN/FEHTEw7eky8mjrrKtq5z2
 SfEUOnMVcgzQAii2RCTE/N9K1hYmPnXoFd5o6GXqWp3BnU+VFlRFgg/wbDNX0NJZoc0k2h0QK
 S2glSthfJ5LBmaNlyM+ceNI8GTkqEuAR1UddNhzlCoarusm/+aIDahzmymeNsQbo2yK5GE1Kf
 60mL+acyYReK5zYYhIQMxJ4HrHOtGOmD9q4t1BFfoPldhSBOMa1lzvpb95AROJVPTcAJvbuUJ
 Al8xetKKfXP+H1hnFXb60iJTs1Po2PrEZY0rqNRLNaCE8DqCxpwtQrrH83QNZVYFF0GL2FiHZ
 bW0no/mEUJtWHdtWWuZidmEyV5kQ4yXLQ9N6RsfGkcbZot8Vkq9iL3bV0JY01nh3iFhpsgNnO
 rKwoXFY6dG9jEkYQMvRy180YaG42nXfqJsnYQQBh+72UE63m0R/nk26/sWSWA91yLyr6d57vB
 i4LMWBLojraldB+lNxfiEwQ0iFCOIda+4dfzZ5Px1lvPA1Q/mleiGW3e8e1lroXCxYArmx6JO
 qho4+tBmxfs0vFWzycmfkbOb/ZvjFARAsJqWDJn3PTWbtqWj+bEPePQ9oAEsbTfNyspkIDmx+
 51jXdLitLSZ+LJOn5I1bVk4DsQrvrIWaZi3n+Ek1Vbf0jdy03t3/ZYYHENmlJKErktzoktymd
 AqoPDpAqFWk0bAbTNmiEAswmgClkQ83/MK1QAdK4BTEN0XvsPJ2+ntc+1KJd8iCH3zkqLXLxY
 1YrNBCf4TgcITLd6olsj8RDBkzxePcSc1vAP5+MqPkXGxeM7af8Mg9v8CfgkFZmghn/uxyXr8
 ZgWq9MSaLKMQtESlpMMsknytjSKcyrIIR2r8gBBSjgMs91aWnMgGUVnQ62M/HE3d7C4+GUVqy
 zHUGi2Owi47Zuqg0TuNET+VJs47X/5TEzEUxsS6XgwGbGlsF1sDlOAallWNyuNRRrp6deaitr
 AOuMipXKgzpvjgAqQppPgejuuEi7qrPKhh3Gigx+djCGrowMB+ZLp84b7Sr/q8lLgwfeHJhgm
 tszrMJ8iJ63+SV7d8Dt++iUed25SYEMNbDNHtSpz6LFZaQzzWHhgCOmj7ZmPvUKDbfV0UvMo1
 LVCyA8tCD3zaJxt2Z60/xm6o+urQxraA5YzICRGbk1sxSmx+H3+dI0eUCDqN0WYN/ZtG3SgJH
 auwVZzXlvTtqKJUaEnM4g3MqjVou/ja+L0Vk/URow1bwk7XOzp5vu0mVFnd7Xjv8vlePdu37N
 Sof8t/ydOuw++pHdfbrjeqHc7+abdBCmVjND6z91wr6TQfUV1oZE5EBpvptiJAgSTHZMCBkg7
 iKg6MECCjSXx+wC/9cM0W9D0z11TFv2rjSFFxkZ1r4RMcygJ8furKaupjhuWXdUdddSsBWTj6
 VSatxpDIa/A/Ql4FnXSqQIv9KwC4Ra4n72JqrRpfar6OKMQe/iQGpypf7lBez8FvgJvvVn/G1
 nzKVy8GJORNV0WKjMVz9IFsAOgUaXTz/VIh6yxT0ptdYOTt6vzxwaohCfi3Dqa+TcmiUh4jYb
 aLbT3OmvLgDMjMmVr19tdMbjjvauUwcxlf4BK7sZOZXSGT7Q+nWeewhmtzNfX900haqxeGrZX
 A4TX9BHSPag80ZPZnmic1OrGou3Qyukq/vCwNUQlpA7XDFArimHm1hlrBQY6XxHeURR2Enwub
 X8XOsq/cgsM1ZUcvjtYc1X4En64AlV2kMVJxDOyaDOQUs2HSsZ2SuSHLWA/0+rQ6cODmDhED4
 FLYGoOnsE3yIjtDFb6i1Kc5ELe4MmuN9DweH/UaQQLSUhLu6cpK+GDTm3aLm2Vzt1bnOg7PnQ
 GTNODz5AZR6FrOhjHjV1XDSZmilTYUIBJ9hB3SUJwWYSZgOs0UYlz9kF1KrDgsK8tNSh6u+a+
 oGyvSKVE8YWF9DViGSoe2XEozd2I+0T41kIvHseeXeSMBAMPlNpL9X7MX9O7Iyb1wGud5kG4j
 4FSt08kLDuo4TAHaF6hV8VLB7VyTIdke7pi9bgZsD3NhYSAXn/alWL/b4XIMPrW1YTvmUAO6c
 A5X0U66zmk7dB/0L3WeeozDBd1ytswvNC+JFVWGjB2Dr3vZizixF2tLxcFgwCIYtQ3KzJ9hef
 LYteOs2D45ePu967hNXirJkdulPqmUshOLUV6FRs9al2/+MepzyFWBvB73CcKtrsMBRTKY/Af
 LnFd3z/cV2g5EL4RePLYpiB/kpfB7ENVx1cfXicBtTZg5lLgixpOPPKhqaPEvKa+oapSRimII
 6dVyjrRqou4OrD19oYmEW5NPL8CsilQWW24ynNs9pvxG8ooc4LUbfD8uVG7RCiLkEgSc/Pmy0
 nSsaPhNGLlnp/bhXgFmhSBMcFktmcZDZOVFwl3BkddY6SZSy3g5z7tKfPZJBFhdYHtKCS+PK3
 YtjAXvI7jzN8PX1Sn4ZBt
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/25/26 00:26, Pierrick Bouvier wrote:
> On 7/24/2026 2:42 PM, Helge Deller wrote:
>> On 7/24/26 18:48, Pierrick Bouvier wrote:
>>> On 7/24/2026 9:01 AM, no92 via qemu development wrote:
>>>> The members are declared as __kernel_pid_t in Linux UAPI headers.
>>>> Analogous members in struct target_shmid_ds (shm_[cl]pid) are also
>>>> declared as abi_int.
>>>>
>>>> Fixes: 1c54ff97bbde ("linux-user: fix and cleanup IPCOP_msg* ipc
>>>> calls handling")
>>>> Signed-off-by: no92 <leo@managarm.org>
>>>> ---
>>>>  =C2=A0 linux-user/syscall.c | 12 ++++++------
>>>>  =C2=A0 1 file changed, 6 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>>>> index 3da5530d42..616d543c7f 100644
>>>> --- a/linux-user/syscall.c
>>>> +++ b/linux-user/syscall.c
>>>> @@ -4234,8 +4234,8 @@ struct target_msqid_ds
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong __msg_cbytes;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong msg_qnum;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 abi_ulong msg_qbytes;
>>>> -=C2=A0=C2=A0=C2=A0 abi_ulong msg_lspid;
>>>> -=C2=A0=C2=A0=C2=A0 abi_ulong msg_lrpid;
>>>> +=C2=A0=C2=A0=C2=A0 abi_int msg_lspid;
>>>> +=C2=A0=C2=A0=C2=A0 abi_int msg_lrpid;
>>> ...
>>>
>>> The change looks correct in itself.
>>
>> No.
>> abi_ulong is wrong, but abi_int isn't much better either if you look at
>> the kernel sources:
>>
>=20
> I wrongly assumed the definition we had on bsd-user side was correct,
> but didn't really think about checking it in linux sources, sorry.

don't worry...

Leo (no92), will you send an updated patch?

Helge

