Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0918CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 04:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFVs-0001Hx-Ba; Wed, 24 Jun 2026 00:47:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcFVi-0001Ea-5g
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 00:46:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcFVf-0002Uv-D7
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 00:46:49 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65O1TauX1307483
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 04:46:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JZ6e3qC4+mQI/aAYzEsV+XdVlU8COhteN2DgiPkMhmY=; b=oYGSCk+HTqaI4D04
 62a+WLRHN/UBdPm4FQD6DyOSH4AbNcHLkm4vWmGEc79r2Vkc8kMi+04VECo5Tx7O
 wsDt6ew40NP5DngtDulCqdZyFUUFSpkh0mEe8EMuRYGLWzulRMtCg/FGZyoCIcpQ
 YqaEDlKKYW52+fjd3uJKIVLD2u6SePbAAMe2ynN0pup8EPc+vFuY/3OGceHfdX07
 NxeM9xOUkBslYAMSpek6cH3KoKPualikH46qYA6EZrF5GzrchV3GcPs+uvBDz1tz
 AqpasTKMiScyy905GhhSRByf23otXR21qBLOBytw+qThyUKLTfUAGuZS5a0OBNX5
 wy8DGA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eysv3kcws-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 04:46:44 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30c0c489e72so669141eec.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 21:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782276403; x=1782881203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JZ6e3qC4+mQI/aAYzEsV+XdVlU8COhteN2DgiPkMhmY=;
 b=HwZBE3tVD6TmgnnL32XyZz4HmC6ZRaoT0mj35tednc5wBBRU3Z4+2HFK6RgMZP9wFz
 X4wsOuMMLE79XDz9zI0GH7IpYcrgij/yHvV8yBA3w/3fa299PhMIneHC0rnHpKEYOAkJ
 SYBuwnOjn+2W4lm8CWDNC0gUmw5di7B7JXDLA7ivtqc4Gf7Fl+2M+8u6oBJDM6tBgWwX
 SNJFZtT7RUbBA0HIINRVra7VjG5meCx84VE58rX2DXY1ydh2qOfH4JgP2h5xRVvUBgeG
 3rd5mRJ/8YjCo9EcniEhmLEoQsajB2EwSxIzoF8SY5LDpUB4mplj7jj4ziufHcivfEOn
 VnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782276403; x=1782881203;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JZ6e3qC4+mQI/aAYzEsV+XdVlU8COhteN2DgiPkMhmY=;
 b=iQWsBVOHTn4FV7uKW7AgHLF1APtQThkoUfWVe+gZQv7KJi66jm9F7G14Ihs98jGFZb
 2cG9W8LbhESgJxwibPYxpIA4drT4FuHORviSoDFTlnvVOXAS0YzsZ7pjwzDUDQZ9Ab27
 eK7g00TfY06uyMrJIIFnK2a0VOrBcMSpbI//ZJCz7bPK8Er8A+iYuxuP3QDm1+HSsJVW
 YmQGXZSmFKZuC0ohbVmRJMbsZTEmfedscOBVyOQS9rfNDbGD1GGqqKYGioRAwahcsQfp
 iTRIcjAAOEC7yRCqPQefG5h3/FJ6RYlnOAPmfgtmP1mOnNqTXxAfNezjBUuGqG1V29jB
 gSfw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpkDOEYS8a87JM9pDhLedqnJRH8pL5/JdTTf2iXaHtTCl15cNacrx5Q7wOC2FUt659uu+6OhaI40ZGb@nongnu.org
X-Gm-Message-State: AOJu0YwwPgMChbXN8RHMpfJmpi1ye/1x2kOtAVsSdzW4n9C1Hlh2n5Nn
 lxTOKyHIdDzLsDEBXyJsXFvNGdAgJaqxxRIHf1H/JPibdLFgtPLfk/5yyfNOLJ56HO04RGwJau4
 42NomWS1mBwgJKcC0d64tbD0Oup/zVBnHgrG8FRI3NDvmbxvFJOz0C5YPDQ==
X-Gm-Gg: AfdE7cmx3zMXXeMViuiP/Mj0jzJE+YoxEs/vz9+41GeypRG6h2R7uvSwCDs4ofyOfVF
 LkU2LhitG80hYCcLoNt5QQnculGv0nzAxdzmarwtLRjSVaYX4Xk5CLWyXMxXGyq7QvbGhCxPgTN
 m0YmUpgvP82pQM/cZICj0f4Wtpq5igobgW6h0kRlaOgHK/Sk+L6UlxttqcCrzbzlXW7mu9MdA/C
 asbj4dfFP1Bd+I1hXFRd4Nvz3g5GsXVpb2bVqWa24eBlGUAHVABGSqfABRSIR07hjP3ChitF+kB
 0zcdEPE/7TikV+NJ54CQMkY1Nphwet0cQtFwT/TwPm63kATDoBQ8zIqnjhNXlXaQVyc6AthZaTp
 udH5rpqS8hafPsQ3xl/Xnwf0rvVV0prWUH5Jvfa7u+uYeR04TY8m1RGx4SvNXm9MhOYIa2e3TCc
 rp9QY=
X-Received: by 2002:a05:7300:1903:b0:303:f26f:df30 with SMTP id
 5a478bee46e88-30c69325f6dmr2061997eec.23.1782276403520; 
 Tue, 23 Jun 2026 21:46:43 -0700 (PDT)
X-Received: by 2002:a05:7300:1903:b0:303:f26f:df30 with SMTP id
 5a478bee46e88-30c69325f6dmr2061981eec.23.1782276402881; 
 Tue, 23 Jun 2026 21:46:42 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bde9335sm20137449eec.21.2026.06.23.21.46.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 21:46:42 -0700 (PDT)
Message-ID: <31d392fa-6691-49a2-ab53-04c6418e0a9a@oss.qualcomm.com>
Date: Tue, 23 Jun 2026 21:46:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Record maintainer/reviewer Git Lab handles
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20260622113152.1710585-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260622113152.1710585-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDAzNiBTYWx0ZWRfX7v+Jq1kKsE3D
 MJA24shkN2bGCKOn12cus4DiPBmhkAdupIOw1DMl5EEV+LuVWyebHHGL4ukK4KNCMMztHEhlQ3D
 7WsX9vYs/5bsnotGn+MmuYRZK8ugpVw=
X-Authority-Analysis: v=2.4 cv=WtAb99fv c=1 sm=1 tr=0 ts=6a3b6134 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=REwzQqOBAAAA:8 a=IVd6x8OzQaOUoZuiaiUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=8XF_WGNd4qQvm41dh321:22
X-Proofpoint-ORIG-GUID: mu5JMaaGaH9-oizQiB4RysYZQFlBxOAA
X-Proofpoint-GUID: mu5JMaaGaH9-oizQiB4RysYZQFlBxOAA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDAzNiBTYWx0ZWRfX0i1oqa3YedrG
 STEvtbSMIWmsjjBfpqvin/U8z4H7A9GdMlqEn1AlJRYidUfbi2YU6jE5kgWfHXgggFghQvbdhIO
 /biikJl6nrf3mOL7WMiAO5hS1SjE872+fDCmDuATk9vbX1LLUkJbRRtHHoVBe0cdh8w3fyt5WbN
 Pxq/agMRrrHPBRGLJjr6VpUL0Pm6x1pcKgqVIR/dIaYNY7nfuDfs+28EGbslvVC7NTe9MBWzrGc
 qdatJ5oN0q6gbpstetUEvRbfP/EYHJLn3tv+6lAPY4RKL0LfjLMmDlLfVm8Y1ssmwN7sU1pCEtJ
 eAffb21vaui+jsz9oQxihrSoArp1X3T4LE1PEhnxmUruVdlTod4b/rT4BDkrJINpFj/pGa2Xpri
 raatMaSDNsceCBleOlZUzBuGIcVEFNCBeXH0VLMpdxi6qzUMejVYLnuad/cL2TxUOcL6+9uvedk
 jmWuGq4XoyM4mqbWqrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_01,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240036
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 6/22/2026 4:31 AM, Daniel P. Berrangé wrote:
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
> This simplifies that by adding a "--gitlab" option to the
> get_maintainer.pl script that will report the GitLab handle
> for maintainers / reviewers too.
> 
> MAINTAINERS is then updated with all known accounts.
> 
> Ignoring bot accounts, there are the following GitLab accounts
> for people whom are not in MAINTAINERS as a Reviewer/Maintainer:
> 
>     Aihua Liang (aliang1)
>     Anthony Roberts (anthony-linaro)
>     Bastian Koppelmann (kbastian-qemu)
>     Eduardo Habkost (ehabkost)
>     Eldon (eldondev)
>     Emilio Cota (cota_)
>     Jim MacArthur (jmacarthur)
>     Joaquin de Andres (xcancerberox)
>     Juan Quintela (juan.quintela)
>     Paul Zimmerman (pauldzim)
>     Peter Krempa (pipo.sk)
>     Peter Krempa (work) (pkrempa)
> 
> Much more significantly, there are the following people present
> in MAINTAINERS, whom are not members of the GitLab project:
> 
>     Aditya Gupta <adityag-#-linux-#-ibm-#-com>
>     Akihiko Odaki <odaki-#-rsg-#-ci-#-i-#-u-tokyo-#-ac-#-jp>
>     Albert Esteve <aesteve-#-redhat-#-com>
>     Alberto Garcia <berto-#-igalia-#-com>
>     Alejandro Jimenez <alejandro-#-j-#-jimenez-#-oracle-#-com>
>     Aleksandar Rikalo <arikalo-#-gmail-#-com>
>     Alessandro Di Federico <ale-#-rev-#-ng>
>     Alexandre Iooss <erdnaxe-#-crans-#-org>
>     Alexandre Ratchov <alex-#-caoua-#-org>
>     Alexey Kardashevskiy <aik-#-ozlabs-#-ru>
>     Amit Shah <amit-#-kernel-#-org>
>     Andrew Jeffery <andrew-#-codeconstruct-#-com-#-au>
>     Anthony PERARD <anthony-#-xenproject-#-org>
>     Anton Johansson <anjo-#-rev-#-ng>
>     Antony Pavlov <antonynpavlov-#-gmail-#-com>
>     Ari Sundholm <ari-#-tuxera-#-com>
>     Artyom Tarasenko <atar4qemu-#-gmail-#-com>
>     Aurelien Jarno <aurelien-#-aurel32-#-net>
>     BALATON Zoltan <balaton-#-eik-#-bme-#-hu>
>     Ben Chaney <bchaney-#-akamai-#-com>
>     Bernhard Beschow <shentey-#-gmail-#-com>
>     Bibo Mao <maobibo-#-loongson-#-cn>
>     Brad Smith <brad-#-comstyle-#-com>
>     Canokeys.org <contact-#-canokeys-#-org>
>     Chao Liu <chao-#-liu-#-zevorn-#-gmail-#-com>
>     Chinmay Rath <rathc-#-linux-#-ibm-#-com>
>     Christoph Muellner <christoph-#-muellner-#-vrull-#-eu>
>     Clément Chigot <chigot-#-adacore-#-com>
>     Clément Mathieu--Drif <clement-#-mathieu--drif-#-bull-#-com>
>     Collin Walling <walling-#-linux-#-ibm-#-com>
>     Corey Minyard <cminyard-#-mvista-#-com>
>     Denis V. Lunev <den-#-openvz-#-org>
>     Dmitry Fleytman <dmitry-#-fleytman-#-gmail-#-com>
>     Dmitry Osipenko <dmitry-#-osipenko-#-collabora-#-com>
>     Dorjoy Chowdhury <dorjoychy111-#-gmail-#-com>
>     Doru Blânzeanu <dblanzeanu-#-linux-#-microsoft-#-com>
>     Edgar E. Iglesias <edgar-#-iglesias-#-gmail-#-com>
>     Elena Ufimtseva <elena-#-ufimtseva-#-oracle-#-com>
>     Eric Auger <eric-#-auger-#-redhat-#-com>
>     Eric Farman <farman-#-linux-#-ibm-#-com>
>     Eugenio Pérez <eperezma-#-redhat-#-com>
>     Farhan Ali <alifm-#-linux-#-ibm-#-com>
>     Felipe Balbi <balbi-#-kernel-#-org>
>     Francisco Iglesias <francisco-#-iglesias-#-amd-#-com>
>     Frederic Konrad <konrad-#-frederic-#-yahoo-#-fr>
>     Gaurav Sharma <gaurav-#-sharma_7-#-nxp-#-com>
>     Gautam Gala <ggala-#-linux-#-ibm-#-com>
>     Gautam Menghani <gautam-#-linux-#-ibm-#-com>
>     Giuseppe Lettieri <g-#-lettieri-#-iet-#-unipi-#-it>
>     Glenn Miles <milesg-#-linux-#-ibm-#-com>
>     Gonglei <arei-#-gonglei-#-huawei-#-com>
>     Haixu Cui <quic_haixcui-#-quicinc-#-com>
>     Halil Pasic <pasic-#-linux-#-ibm-#-com>
>     Hao Wu <wuhaotsh-#-google-#-com>
>     Hari Bathini <hbathini-#-linux-#-ibm-#-com>
>     Hendrik Brueckner <brueckner-#-linux-#-ibm-#-com>
>     Hervé Poussineau <hpoussin-#-reactos-#-org>
>     Hongren (Zenithal) Zheng <i-#-zenithal-#-me>
>     Huacai Chen <chenhuacai-#-kernel-#-org>
>     Hyman Huang <infra-#-ai-#-cloud-#-bitdeer-#-com>
>     Ilya Dryomov <idryomov-#-gmail-#-com>
>     Ilya Leoshkevich <iii-#-linux-#-ibm-#-com>
>     Ilya Maximets <i-#-maximets-#-ovn-#-org>
>     Jagannathan Raman <jag-#-raman-#-oracle-#-com>
>     Jamin Lin <jamin_lin-#-aspeedtech-#-com>
>     Jan Kiszka <jan-#-kiszka-#-web-#-de>
>     Jared Rossi <jrossi-#-linux-#-ibm-#-com>
>     Jason Herne <jjherne-#-linux-#-ibm-#-com>
>     Jean-Christophe Dubois <jcd-#-tribudubois-#-net>
>     Jesper Devantier <foss-#-defmacro-#-it>
>     Jeuk Kim <jeuk20-#-kim-#-samsung-#-com>
>     Jiaxun Yang <jiaxun-#-yang-#-flygoat-#-com>
>     Jiri Pirko <jiri-#-resnulli-#-us>
>     Jiri Slaby <jslaby-#-suse-#-cz>
>     Joe Komlodi <komlodi-#-google-#-com>
>     Joel Stanley <joel-#-jms-#-id-#-au>
>     John Levon <john-#-levon-#-nutanix-#-com>
>     Jonathan Cameron <jic23-#-kernel-#-org>
>     Kane Chen <kane_chen-#-aspeedtech-#-com>
>     Kashyap Chamarthy <kchamart-#-redhat-#-com>
>     Keith Busch <kbusch-#-kernel-#-org>
>     Kohei Tokunaga <ktokunaga-#-mail-#-gmail-#-com>
>     Kuan-Wei Chiu <visitorckw-#-gmail-#-com>
>     Kyle Evans <kevans-#-freebsd-#-org>
>     LIU Zhiwei <zhiwei_liu-#-linux-#-alibaba-#-com>
>     Leif Lindholm <leif-#-lindholm-#-oss-#-qualcomm-#-com>
>     Li Zhijian <lizhijian-#-fujitsu-#-com>
>     Li-Wen Hsu <lwhsu-#-freebsd-#-org>
>     Liu Zhiwei <zhiwei_liu-#-linux-#-alibaba-#-com>
>     Luc Michel <luc-#-lmichel-#-fr>
>     Lukas Straub <lukasstraub2-#-web-#-de>
>     Maciej S. Szmigiero <maciej-#-szmigiero-#-oracle-#-com>
>     Mads Ynddal <mads-#-ynddal-#-dk>
>     Magnus Kulke <magnuskulke-#-linux-#-microsoft-#-com>
>     Maksim Davydov <davydov-max-#-yandex-team-#-ru>
>     Marcelo Tosatti <mtosatti-#-redhat-#-com>
>     Mark Kanda <mark-#-kanda-#-oracle-#-com>
>     Markus Armbruster <armbru-#-redhat-#-com>
>     Mathieu Poirier <mathieu-#-poirier-#-linaro-#-org>
>     Matthew Rosato <mjrosato-#-linux-#-ibm-#-com>
>     Mauro Carvalho Chehab <mchehab+huawei-#-kernel-#-org>
>     Max Filippov <jcmvbkbc-#-gmail-#-com>
>     Michael Rolnik <mrolnik-#-gmail-#-com>
>     Milan Zamazal <mzamazal-#-redhat-#-com>
>     Nabih Estefan <nabihestefan-#-google-#-com>
>     Niek Linnenbank <nieklinnenbank-#-gmail-#-com>
>     Ninad Palsule <ninad-#-linux-#-ibm-#-com>
>     Palmer Dabbelt <palmer-#-dabbelt-#-com>
>     Patrick Leis <venture-#-google-#-com>
>     Paul Durrant <paul-#-xen-#-org>
>     Pavel Pisa <pisa-#-cmp-#-felk-#-cvut-#-cz>
>     Pedro Barbuda <pbarbuda-#-microsoft-#-com>
>     Peter Lieven <pl-#-dlhnet-#-de>
>     Peter Xu <peterx-#-redhat-#-com>
>     Phil Dennis-Jordan <phil-#-philjordan-#-eu>
>     Philipp Tomsich <philipp-#-tomsich-#-vrull-#-eu>
>     Ran Wang <wangran-#-bosc-#-ac-#-cn>
>     Raphael Norwitz <rnorwitz-#-nvidia-#-com>
>     Reinoud Zandijk <reinoud-#-netbsd-#-org>
>     Richard W.M. Jones <rjones-#-redhat-#-com>
>     Roman Bolshakov <rbolshakov-#-ddn-#-com>
>     Sai Pavan Boddu <sai-#-pavan-#-boddu-#-amd-#-com>
>     Sairaj Kodilkar <sarunkod-#-amd-#-com>
>     Samuel Tardieu <sam-#-rfc1149-#-net>
>     Samuel Thibault <samuel-#-thibault-#-ens-lyon-#-org>
>     Sergio Lopez <slp-#-redhat-#-com>
>     Song Gao <gaosong-#-loongson-#-cn>
>     Sourabh <sourabhjain-#-linux-#-ibm-#-com>
>     Sourabh Jain <sourabhjain-#-linux-#-ibm-#-com>
>     Sriram Yagnaraman <sriram-#-yagnaraman-#-ericsson-#-com>
>     Stafford Horne <shorne-#-gmail-#-com>
>     Stefano Stabellini <sstabellini-#-kernel-#-org>
>     Steven Lee <steven_lee-#-aspeedtech-#-com>
>     Strahinja Jankovic <strahinja-#-p-#-jankovic-#-gmail-#-com>
>     Subbaraya Sundeep <sundeep-#-lkml-#-gmail-#-com>
>     Sunil V L <sunilvl-#-ventanamicro-#-com>
>     Sven Schnelle <svens-#-stackframe-#-org>
>     Tao Tang <tangtao1634-#-phytium-#-com-#-cn>
>     Thanos Makatos <thanos-#-makatos-#-nutanix-#-com>
>     Titus Rwantare <titusr-#-google-#-com>
>     Tomita Moeko <tomitamoeko-#-gmail-#-com>
>     Tony Krowiak <akrowiak-#-linux-#-ibm-#-com>
>     Troy Lee <leetroy-#-gmail-#-com>
>     Tyrone Ting <kfting-#-nuvoton-#-com>
>     Vikram Garhwal <vikram-#-garhwal-#-bytedance-#-com>
>     Viktor Prutyanov <viktor-#-prutyanov-#-phystech-#-edu>
>     Vincenzo Maffione <v-#-maffione-#-gmail-#-com>
>     Viresh Kumar <viresh-#-kumar-#-linaro-#-org>
>     WANG Xuerui <git-#-xen0n-#-name>
>     Wei Liu <wei-#-liu-#-kernel-#-org>
>     Weiwei Li <liwei1518-#-gmail-#-com>
>     Xie Yongji <xieyongji-#-bytedance-#-com>
>     Yi Liu <yi-#-l-#-liu-#-intel-#-com>
>     Yonggang Luo <luoyonggang-#-gmail-#-com>
>     Yoshinori Sato <yoshinori-#-sato-#-nifty-#-com>
>     Yuri Benditovich <ybendito-#-redhat-#-com>
>     Zhang Chen <zhangckid-#-gmail-#-com>
>     Zhao Liu <zhao1-#-liu-#-intel-#-com>
>     Zhenzhong Duan <zhenzhong-#-duan-#-intel-#-com>
>     Zhuoying Cai <zycai-#-linux-#-ibm-#-com>
>     zhenwei pi <zhenwei-#-pi-#-linux-#-dev>
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
> Daniel P. Berrangé (3):
>   get_maintainer: add ability to report Git Lab handle
>   MAINTAINERS: record known Git Lab handles for all maintainers
>   MAINTAINERS: record known Git Lab handles for all reviewers
> 
>  MAINTAINERS               | 396 ++++++++++++++++++++++++++++++++++++++
>  scripts/get_maintainer.pl |  17 +-
>  2 files changed, 411 insertions(+), 2 deletions(-)
> 

My gitlab account is p-b-o.

Thanks,
Pierrick

